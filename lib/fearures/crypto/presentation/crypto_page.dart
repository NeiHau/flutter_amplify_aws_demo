import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/in_memory_store.dart';
import '../client/crypto_client.dart';

class CryptoScreen extends ConsumerWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceUSDAsyncValue = ref.watch(bitcoinPriceUSDProvider);
    final priceJPYAsyncValue = ref.watch(bitcoinPriceJPYProvider);
    final previousPriceUSD = ref.watch(previousPriceUSDProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            priceUSDAsyncValue.when(
              data: (priceUSD) {
                // Compare the current price with the last price
                final iconUSD = (previousPriceUSD.state.value ?? 0.0) > priceUSD
                    ? Icons.arrow_downward
                    : Icons.arrow_upward;

                // Update the last price
                previousPriceUSD.state.value = priceUSD;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bitcoin Price: $priceUSD USD',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Icon(iconUSD, color: Colors.red), // Add the arrow icon
                  ],
                );
              },
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
