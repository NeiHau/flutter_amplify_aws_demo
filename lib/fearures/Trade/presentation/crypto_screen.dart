import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/crypto_client.dart';

class BitCoinScreen extends ConsumerWidget {
  const BitCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceUSDAsyncValue = ref.watch(bitcoinPriceUSDProvider);
    final priceJPYAsyncValue = ref.watch(bitcoinPriceJPYProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            priceUSDAsyncValue.when(
              data: (priceUSD) => Text(
                'Bitcoin Price: $priceUSD USD',
                style: const TextStyle(fontSize: 24),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) =>
                  const Text('Failed to load bitcoin price in USD.'),
            ),
            priceJPYAsyncValue.when(
              data: (priceJPY) => Text(
                'Bitcoin Price: $priceJPY 円',
                style: const TextStyle(fontSize: 24),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) =>
                  const Text('Failed to load bitcoin price in JPY.'),
            ),
          ],
        ),
      ),
    );
  }
}
