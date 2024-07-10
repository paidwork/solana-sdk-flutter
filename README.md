<p align="center">
  <img src="https://zrcdn.net/static/img/logos/paidwork/paidwork-logo-github.png" alt="Paidwork" />
</p>

<h3 align="center">
  Send & Receive secure Blockchain transactions on Solana with Worken
</h3>
<p align="center">
  🚀 Over 20M+ Users using Worken!
</p>

<p align="center">
  <a href="https://github.com/paidworkco/worken-sdk-flutter">
    <img alt="GitHub Repository Stars Count" src="https://img.shields.io/github/stars/paidworkco/worken-sdk-flutter?style=social" />
  </a>
    <a href="https://x.com/paidworkco">
        <img alt="Follow Us on X" src="https://img.shields.io/twitter/follow/paidworkco?style=social" />
    </a>
</p>
<p align="center">
    <a href="https://pub.dev/packages/worken_sdk"><img src="https://img.shields.io/pub/v/worken_sdk" alt="Pub"></a>
    <a href="http://commitizen.github.io/cz-cli/">
        <img alt="Commitizen friendly" src="https://img.shields.io/badge/commitizen-friendly-brightgreen.svg" />
    </a>
    <a href="https://github.com/paidworkco/worken-sdk-php">
        <img alt="License" src="https://img.shields.io/github/license/paidworkco/worken-sdk-php" />
    </a>
    <a href="https://github.com/paidworkco/worken-sdk-php/pulls">
        <img alt="PRs Welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" />
    </a>
</p>

SDK library providing access to make easy and secure Blockchain transactions with Worken. <a href="https://www.paidwork.com/worken?utm_source=github.com&utm_medium=referral&utm_campaign=readme" target="_blank">Read more</a> about Worken Token.

## Configuration
To ensure flexibility and ease of integration, the Worken SDK allows for configuration through environmental variables. These variables can be set directly in your project's .env file. Below is a list of available configuration variables along with their descriptions:

To get more information about those below, please [read it](https://solana.com/docs/core/clusters)

```rpcUrl```: rpcUrl

```websocketUrl```: websocketUrl
## Usage
#### Install

```
 $ flutter pub add worken-sdk 
```
#### Initialization
```dart
import 'package:worken_sdk/worken_sdk.dart';
import 'package:solana/solana.dart';
import 'package:get_it/get_it.dart';

/// Setup even if don't want to use your paths
await WorkenSdk.setup( 
      typeNet: typeNet
      provider: SolanaClient(rpcUrl, websocketUrl),
      locator: GetIt.instance, // your locator
    );
```
| **Parameter** | **Type** | **Description** |
|:------:|:----:|----
| ```typeNet``` | ```SolanaNet``` | if provider is null, please set typeNet (mainNet, devNet, testNet) |
| ```provider``` | ```SolanaClient``` | if want to use yours client |
| ```locator``` | ```GetIt``` | if want to use yours locator |
### Wallet
```dart
WorkenSdk.getWalletService(); /// Service to extract functions
```
also, if setup with locator
```dart
 locator.get<WalletService>(); /// Get service from locator
```
#### Get wallet balance
```dart
WorkenSdk.getWalletService().getBalance(address: address);
```
| **Parameter** | **Type** | **Description** |
------|----|----
| ``address`` | ``String`` | **Required** Your wallet address |

This structure details the balance of a wallet in terms of the WORK token specified in contract
It returns TokenAmount model which contains data like:    
 - `amount`: as `String` - raw amount of tokens as a `string`, ignoring decimals  
 - `decimals`: as `int` - number of decimals configured for token's mint  
 - `uiAmountString`: as `String?` - token amount as a string, accounting for decimals  

#### Get wallet transaction history
```dart
WorkenSdk.getWalletService().getTransactions(address: address);
```
| **Parameter** | **Type** | **Description** |
------|----|----
| ``address`` | ``String`` | **Required** Your wallet address |

This method returns list of `TransactionSignatureInformation` that contains data like:

- `signature`: as `String` - transaction signature as `base-58 encoded string`
- `slot`: as `int` - the slot that contains the block with the transaction
- `err`: as `Map<String, dynamic>?` - contains error details
- `memo`: as `String?` - memo associated with the transaction, `null` if no nemo is present
- `blockTime`: as `int?` - estimated production time, as `Unix timestamp` of when transaction was processed. `Null` if not available
- `confirmationStatus`: as `ConfirmationStatus?` - the transaction's cluster confirmation status

#### Create new wallet
```dart
WorkenSdk.getWalletService().createWallet();
```

Creates and initializes the account SolanaWallet and the change account for the given `bip39 mnemonic string of 12 words`.
Omitting account or change means they will be `null` with the following rules of the meaning of null in this context.
If either account or change is null, and the other is not, `then it will be taken to be zero`.

### Contract
```dart
WorkenSdk.getContractService(); /// Service to extract functions
```
also, if setup with locator
```dart
 locator.get<ContractService>(); /// Get service from locator
```
#### Show contract status 
```dart
WorkenSdk.getContractService().getContractStatus();
```

This method returns all information associated with the account of provided Pubkey

- `lamports`: as `int` - number of lamports assigned to this account, as a u64
- `owner`: as `String` - base-58 encoded Pubkey of the program this account has been assigned to
- `data`: as `AccountData?` - data associated with the account, either as encoded binary data or JSON format
- `executable`: as `bool` - boolean indicating if the account contains a program
- `rentEpoch`: as `BigInt` - the epoch at which this account will next owe rent, as u64

### Transactions
```dart
WorkenSdk.getTransactionService(); /// Service to extract functions
```
also, if setup with locator
```dart
 locator.get<TransactionsService>(); /// Get service from locator
```

### Prepare transaction
```dart
WorkenSdk.getTransactionService().prepareTransaction({
    required String sourcePrivateKey,
    required String sourceWallet,
    required String destinationWallet,
    required int amount});
```
| Parameter | Type     | Description                                                                     |
| :-------- | :------- | :------------------------------------------------------------------------------ |
| `sourcePrivateKey`   | `String`    | **Required**. Sender private key in base58 |
| `sourceWallet`   | `String`    | **Required**. Receiver wallet address |
| `destinationWallet`   | `String`    | **Required**. Mint address |
| `amount`   | `int`    | **Required**. Amount to send in WORKEN | 0.00001 Worken = 1 |

This function prepares transaction in Worken SPL token
It returns us `txHash String`

#### Send transaction 
```dart
WorkenSdk.getTransactionService().sendTransaction();
```
| Parameter | Type     | Description                                                                     |
| :-------- | :------- | :------------------------------------------------------------------------------ |
| `hashString`   | `String`    | **Required**. prepared txHash |

This function sends prepared transaction
It returns us `signature hash String`

#### Show transaction status
```dart
WorkenSdk.getTransactionService().transactionStatus({required String signature});
```

| Parameter | Type     | Description                                                                     |
| :-------- | :------- | :------------------------------------------------------------------------------ |
| `signature`   | `String`    | **Required**. Signature string of transaction |

This function shows us the status of desired transaction we want to check.
It returns us SignatureStatusesResult which contains data like:
- `slot`: as `int` - the slot the transaction was processed 
- `confirmations`: as `ConfirmationStatus` - the transaction's cluster confirmation status 
- `confirmationStatus`: as `int?` - number of block since signature confirmation, `null` if rooted, as well as finalized 
- `err`: as `Map<String, dynamic>` - error message  

### Get estimated fee
```dart
WorkenSdk.getTransactionService().estimatedFee({required String message});
```
| Parameter | Type     | Description                                                                     |
| :-------- | :------- | :------------------------------------------------------------------------------ |
| `message`   | `String`    | **Required**. Typically message is our hashKey |

This function returns us `int?` - estimated Fee we will have to pay 

#### Show recent transactions
```dart
WorkenSdk.getTransactionService().recentTransactions({required String mintAddress, required int limit});
```

| Parameter | Type     | Description                                                                     |
| :-------- | :------- | :------------------------------------------------------------------------------ |
| `mintAddress`   | `String`    | **Required**. Your mint address |
| `limit`         | `int`       | **Required**. Amount of transactions we want to see |

This function returns us `List<TransactionSignatureInformation>` which contains data like:
- `signature`: as `String` - transaction signature as base-58 encoded string
- `slot`: as `int` - the slot that contains the block with the transaction
- `err`: as `Map<String, dynamic>` - error message
- `memo`: as `String?` - memo associated with the transaction, `null` if no memo is present
- `blockTime`: as `int?` - estimated production time, as `Unix timestamp` of when transaction was processed. `null` if not available
- `confirmationStatus`: as `ConfirmationStatus?` - the transaction's cluster confirmation status

### Network
```dart
WorkenSdk.getNetworkService(); /// Service to extract functions
```
also, if setup with locator
```dart
 locator.get<NetworkService>(); /// Get service from locator
```
#### Show block information
```dart
WorkenSdk.getNetworkService().blockInformation(blockNumber: blockNumber);
```
| Parameter     | Type     | Description                   |
| :------------ | :------- | :---------------------------- |
| `blockNumber` | `int`    | **Required**. Number of block |

This function retrieves detailed information about a specific block on the blockchain.
It returns `Block` model which contains data like: 

- `blockhash`: as `String` - the blockhash of this block, as base-58 encoded string 
- `previousBlockhash`: as `String` - the blockhash of this block's parent, as base-58 encoded string. If the parent block is not available due to ledger cleanup, this field will return `1111..11`
- `parentSlot`: as `int` - the slot index of this block's parent 
- `transactions`: as `List<Transaction>`- present if `TransactionDetailLevel.full` transaction details are requested. An array of `Transaction` objects
- `meta`: as `Meta?` - transaction status metadata object 
- `signatures`: as `List<String>` - present if `TransactionDetailLevel.signatures` are requested for transaction details. An array of signatures `strings`, corresponding to the transaction order in the block
- `rewards`: as `List<Reward>` - present if rewards are requested. An array of `Reward` objects 
- `blockTime`: as `int?` - estimated production time, as `Unix timestamp`. `None` if not available 
- `blockHeight`: as `int?` - the number of blocks beneath this block 

#### Show network status
```dart
WorkenSdk.getNetworkService().networkStatus();
```
This function returns a NetworkStatusModel:

- `blockData`: as `int` - the current block height of the node 
- `feeRate` as `int?` - the fee the network will charge for a particular Message

#### Show monitor network congestion
```dart
WorkenSdk.getNetworkService().monitorCongestion();
```

This function returns a list of PerfSample:

- `slot`: as `int` - slot in which sample was taken at
- `numTransactions`: as `int` - number of transactions in sample
- `numSlots`: as `int` - number of slots in sample
- `samplePeriodSecs`: as `int` - number of seconds in a sample window
