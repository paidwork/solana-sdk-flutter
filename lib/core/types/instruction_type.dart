// ignore_for_file: constant_identifier_names

class InstructionTypes<String, int> {
  static const InitializeMint = 1;
  static const InitializeAccount = 1;
  static const InitializeMultisig = 2;
  static const Transfer = 3;
  static const Approve = 4;
  static const Revoke = 5;
  static const SetAuthority = 6;
  static const MintTo = 7;
  static const Burn = 8;
  static const CloseAccount = 9;
  static const FreezeAccount = 10;
  static const ThawAccount = 11;
  static const TransferChecked = 12;
  static const ApproveChecked = 13;
  static const MintToChecked = 14;
  static const BurnChecked = 15;
  static const InitializeAccount2 = 16;
  static const SyncNative = 17;
  static const InitializeAccount3 = 18;
  static const InitializeMultisig2 = 19;
  static const InitializeMint2 = 20;
  static const GetAccountDataSize = 21;
  static const InitializeImmutableOwner = 22;
  static const AmountToUiAmount = 23;
  static const UiAmountToAmount = 24;
  static const InitializeMintCloseAuthority = 25;
  static const TransferFeeExtension = 26;
  static const ConfidentialTransferExtension = 27;
  static const DefaultAccountStateExtension = 28;
  static const Reallocate = 29;
  static const MemoTransferExtension = 30;
  static const CreateNativeMint = 31;
  static const InitializeNonTransferableMint = 32;
  static const InterestBearingMintExtension = 33;
  static const CpiGuardExtension = 34;
  static const InitializePermanentDelegate = 35;
  static const TransferHookExtension = 36;
  static const ConfidentialTransferFeeExtension = 37;
  static const WithdrawalExcessLamports = 38;
  static const MetadataPointerExtension = 39;
  static const GroupPointerExtension = 40;
  static const GroupMemberPointerExtension = 41;
}
