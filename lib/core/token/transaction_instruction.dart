import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class TransactionInstruction {
  List<AccountMeta> keys;
  Ed25519HDPublicKey programId;
  List<int> data;

  TransactionInstruction({
    required this.keys,
    required this.programId,
    required this.data,
  });
}
