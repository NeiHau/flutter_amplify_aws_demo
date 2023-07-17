import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/in_memory_store.dart';
import '../client/crypto_client.dart';

class CryptoScreen extends ConsumerStatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  CryptoScreenState createState() => CryptoScreenState();
}

class CryptoScreenState extends ConsumerState<CryptoScreen> {
  @override
  void dispose() {
    super.dispose();
    // ref.watch(previousPriceUSDProvider).close();
    // ref.watch(previousPriceJPYProvider).close();
  }

  @override
  Widget build(BuildContext context) {
    final priceUSDAsyncValue = ref.watch(bitcoinPriceUSDProvider);
    final priceJPYAsyncValue = ref.watch(bitcoinPriceJPYProvider);

    final previousPriceUSD = ref.watch(previousPriceUSDProvider.notifier);
    final previousPriceJPY = ref.watch(previousPriceJPYProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bitcoin Price',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            priceUSDAsyncValue.when(
              data: (priceUSD) {
                // Store the current price for comparison before updating
                final currentPrice = priceUSD;

                // Compare the current price with the last price
                final iconUSD =
                    (previousPriceUSD.state.value ?? 0.0) > currentPrice
                        ? Icons.arrow_downward
                        : Icons.arrow_upward;

                // Update the last price
                previousPriceUSD.state.value = currentPrice;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$currentPrice USD',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      iconUSD,
                      color: iconUSD == Icons.arrow_downward
                          ? Colors.blue
                          : Colors.red,
                      size: 60.0,
                    ), // Add the arrow icon and specify the color
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) =>
                  const Text('Failed to load bitcoin price in USD.'),
            ),
            const SizedBox(height: 20),
            priceJPYAsyncValue.when(
              data: (priceJPY) {
                // Store the current price for comparison before updating
                final currentPrice = priceJPY;

                final iconJPY =
                    (previousPriceJPY.state.value ?? 0.0) > currentPrice
                        ? Icons.arrow_downward
                        : Icons.arrow_upward;

                previousPriceJPY.state.value = currentPrice;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$priceJPY 円',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      iconJPY,
                      color: iconJPY == Icons.arrow_downward
                          ? Colors.blue
                          : Colors.red,
                      size: 60.0,
                    )
                  ],
                );
              },
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
