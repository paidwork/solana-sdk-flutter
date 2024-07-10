// ignore_for_file: constant_identifier_names
import 'dart:typed_data';

import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart' as encoder;
import 'package:solana/solana.dart' as solana;
import 'package:worken_sdk/core/constants/constants.dart';
import 'package:worken_sdk/core/token/transaction_instruction.dart';

class TokenProgram {
  /// [Prepare transaction]
  ///
  /// [Params]
  ///
  /// [String]        sourcePrivateKey    Sender private key in base58
  /// [String]        senderWallet        Receiver wallet address
  /// [String]        destinationWallet   Mint address
  /// [int]           amount              Amount to send in WORKEN
  /// [SolanaClient]  solanaClient        RPC client
  ///
  /// [Return]
  ///
  /// [String] Transaction hash

  Future<String> prepareTransaction({
    required String sourcePrivateKey,
    required String senderWallet,
    required String destinationWallet,
    required int amount,
    required solana.SolanaClient solanaClient,
  }) async {
    final solana.Ed25519HDPublicKey fromBase58 =
        solana.Ed25519HDPublicKey.fromBase58(sourcePrivateKey);

    final solana.Ed25519HDKeyPair senderKeyPair =
        await solana.Ed25519HDKeyPair.fromSeedWithHdPath(
      seed: fromBase58.bytes,
      hdPath: "m/44'/501'/0'/0'",
    );

    final solana.Ed25519HDPublicKey senderPubKey =
        solana.Ed25519HDPublicKey(base58decode(senderWallet));

    final solana.Ed25519HDPublicKey receiverPubKey =
        solana.Ed25519HDPublicKey(base58decode(destinationWallet));

    final solana.Ed25519HDPublicKey sourceAccount =
        await getOrCreateAssociatedTokenAccount(
      senderKeyPair,
      senderPubKey,
      senderPubKey,
      solanaClient,
    );

    final solana.Ed25519HDPublicKey destinationAccount =
        await getOrCreateAssociatedTokenAccount(
      senderKeyPair,
      senderPubKey,
      receiverPubKey,
      solanaClient,
    );

    final String instruction = await solanaClient.transferSplToken(
      mint: sourceAccount,
      destination: destinationAccount,
      amount: amount,
      owner: senderKeyPair,
    );

    final recentBlockhash = await getRecentBlockhash(solanaClient);

    final transaction = await solana.signTransaction(
      recentBlockhash.value,
      solana.Message.decompile(
        encoder.CompiledMessage(encoder.ByteArray.fromString(instruction)),
      ),
      [senderKeyPair],
    );

    final rawBinaryString = transaction.encode();

    return rawBinaryString;
  }

  /// [Get or create associated token account]
  ///
  /// [Functionality]
  ///
  /// Fetches or creates an associated token account for a given mint and owner.
  ///
  /// [Params]
  ///
  /// [Ed25519HDKeyPair] ownerKeys - The keypair of the account that will own the newly created token account.
  /// [Ed25519HDPublicKey] senderPubKey -  The public key of the token for which an account will be created.
  /// [Ed25519HDPublicKey] accountPubKey -  The public key of the account that will own the newly created token account.
  /// [SolanaClient] solanaClient -  RPC Client
  /// [Ed25519HDPublicKey] - The public key of the associated token account
  ///
  /// [Return]
  ///
  /// [Ed25519HDPublicKey] as new associated account public address

  Future<solana.Ed25519HDPublicKey> getOrCreateAssociatedTokenAccount(
      solana.Ed25519HDKeyPair ownerKeys,
      solana.Ed25519HDPublicKey senderPubKey,
      solana.Ed25519HDPublicKey accountPubKey,
      solana.SolanaClient solanaClient) async {
    final solana.Ed25519HDPublicKey mintPubKey =
        solana.Ed25519HDPublicKey.fromBase58(Constants.MINT_TOKEN);

    final response = await solanaClient.rpcClient.getTokenAccountsByOwner(
      accountPubKey.toBase58(),
      TokenAccountsFilter.byMint(mintPubKey.toBase58()),
    );

    if (response.value.isNotEmpty) {
      final String associatedAccountAddress = response.value[0].pubkey;
      return solana.Ed25519HDPublicKey.fromBase58(associatedAccountAddress);
    }

    final TransactionInstruction instruction =
        await createAssociatedTokenAccountInstruction(
      /// [Sender] is the fee payer
      senderPubKey,
      accountPubKey,
      mintPubKey,
    );

    await solanaClient.rpcClient.signAndSendTransaction(
      solana.Message.only(
        encoder.Instruction(
          accounts: instruction.keys,
          data: encoder.ByteArray(instruction.data),
          programId: instruction.programId,
        ),
      ),
      [ownerKeys],
    );

    final solana.Ed25519HDPublicKey newAssociatedAccountAddress =
        await findAssociatedTokenAddress(
      accountPubKey,
      mintPubKey,
    );

    return newAssociatedAccountAddress;
  }

  Future<AccountResult> getNumberDecimals(solana.Ed25519HDPublicKey mintAddress,
          solana.SolanaClient solanaClient) async =>
      await solanaClient.rpcClient.getAccountInfo(mintAddress.toBase58());

  /// [Create associated token account instruction]
  ///
  /// [Funcionallity]
  ///
  /// Creates an instruction to create an associated token account.
  ///
  /// [Params]
  ///
  /// [Ed25519HDPublicKey] funderPubKey - The public key of the account funding the creation.
  /// [Ed25519HDPublicKey] ownerPubKey - The public key of the account that will own the newly created token account.
  /// [Ed25519HDPublicKey] mintPubKey -  The public key of the token for which an account will be created.
  ///
  /// [Return]
  ///
  /// [TransactionInstruction] class

  Future<TransactionInstruction> createAssociatedTokenAccountInstruction(
    solana.Ed25519HDPublicKey funderPubKey,
    solana.Ed25519HDPublicKey ownerPubKey,
    solana.Ed25519HDPublicKey mintPubKey,
  ) async {
    final List<encoder.AccountMeta> keys = [
      encoder.AccountMeta(
        pubKey: funderPubKey,
        isWriteable: true,
        isSigner: true,
      ),
      encoder.AccountMeta(
        pubKey: await findAssociatedTokenAddress(ownerPubKey, mintPubKey),
        isWriteable: false,
        isSigner: false,
      ),
      encoder.AccountMeta(
        pubKey: ownerPubKey,
        isWriteable: false,
        isSigner: false,
      ),
      encoder.AccountMeta(
        pubKey:
            solana.Ed25519HDPublicKey.fromBase58(Constants.SYSTEM_PROGRAM_ID),
        isWriteable: false,
        isSigner: false,
      ),
      encoder.AccountMeta(
        pubKey:
            solana.Ed25519HDPublicKey.fromBase58(Constants.TOKEN_PROGRAM_ID),
        isWriteable: false,
        isSigner: false,
      ),
      encoder.AccountMeta(
        pubKey: solana.Ed25519HDPublicKey.fromBase58(
            Constants.ASSOCIATED_TOKEN_PROGRAM_ID),
        isWriteable: false,
        isSigner: false,
      ),
    ];

    ByteData data = ByteData(1);
    data.setUint8(0, 1);
    Uint8List packedData = data.buffer.asUint8List();

    return TransactionInstruction(
      keys: keys,
      programId: solana.Ed25519HDPublicKey.fromBase58(
          Constants.ASSOCIATED_TOKEN_PROGRAM_ID),
      data: packedData,
    );
  }

  /// [Find associated token addres]
  ///
  /// [Functionality]
  ///
  /// Finds the address of the associated token account for a given mint and owner.
  ///
  /// [Parameters]
  ///
  /// [Ed25519HDPublicKey] ownerPublicKey
  /// [Ed25519HDPublicKey] mintPublicKey
  ///
  /// [Return]
  ///
  /// [Ed25519HDPublicKey] from programAddress

  Future<solana.Ed25519HDPublicKey> findAssociatedTokenAddress(
      solana.Ed25519HDPublicKey ownerPubKey,
      solana.Ed25519HDPublicKey mintPubKey) async {
    final solana.Ed25519HDPublicKey binaryKey =
        solana.Ed25519HDPublicKey(base58decode(Constants.TOKEN_PROGRAM_ID));

    return solana.Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        ownerPubKey.toByteArray(),
        binaryKey.toByteArray(),
        mintPubKey.toByteArray(),
      ],
      programId: solana.Ed25519HDPublicKey.fromBase58(
          Constants.ASSOCIATED_TOKEN_PROGRAM_ID),
    );
  }

  /// [Get recent blockhash]
  ///
  /// [Functionality]
  ///
  /// Fetches the recent blockhash from the RPC endpoint.
  ///
  /// [Parameters]
  ///
  /// [SolanaClient] solanaClient - RPC Client
  ///
  /// [Return]
  ///
  /// [RecentBlockhashResult] class

  Future<RecentBlockhashResult> getRecentBlockhash(
      solana.SolanaClient solanaClient) async {
    // ignore: deprecated_member_use
    final response = await solanaClient.rpcClient.getRecentBlockhash();
    return response;
  }
}
