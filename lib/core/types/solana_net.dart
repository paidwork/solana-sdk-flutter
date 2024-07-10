enum SolanaNet {
  mainNet(url: 'https://api.mainnet-bet.solana.com'),
  devNet(url: 'https://api.devnet.solana.com'),
  testNet(url: 'https://api.testnet.solana.com');

  final String url;

  const SolanaNet({required this.url});

  Uri get toUri => Uri.parse(url);
}
