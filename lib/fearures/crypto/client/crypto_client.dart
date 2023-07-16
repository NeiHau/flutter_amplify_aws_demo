import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';

final bitcoinPriceUSDProvider = StreamProvider<double>((ref) {
  return CryptoService().getBitcoinPriceUSD();
});

final bitcoinPriceJPYProvider = StreamProvider<double>((ref) {
  return CryptoService().getBitcoinPriceJPY();
});

class CryptoService {
  final Dio _dio = Dio();

  Stream<double> getBitcoinPriceUSD() async* {
    while (true) {
      try {
        Response response = await _dio.get(
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd');
        double price = (response.data['bitcoin']['usd']).toDouble();
        yield price;

        logger.i('Successfully fetched Bitcoin price in USD: $price');
      } catch (e) {
        logger.e('Error fetching Bitcoin price in USD', e);
        rethrow;
      }
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  Stream<double> getBitcoinPriceJPY() async* {
    while (true) {
      try {
        Response response = await _dio.get(
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=jpy');
        double price = (response.data['bitcoin']['jpy']).toDouble();
        yield price;

        logger.i('Successfully fetched Bitcoin price in JPY: $price');
      } catch (e) {
        logger.e('Error fetching Bitcoin price in JPY', e);
        rethrow;
      }
      await Future.delayed(const Duration(seconds: 10));
    }
  }
}

// priceUSDAsyncValue.when(
// data: (priceUSD) {
// // Store the current price for comparison before updating
// final currentPrice = priceUSD;
//
// // Compare the current price with the last price
// final iconUSD =
// (previousPriceUSD.state.value ?? 0.0) > currentPrice
// ? Icons.arrow_downward
//     : Icons.arrow_upward;
//
// // Update the last price
// previousPriceUSD.state.value = currentPrice;
//
// return Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// 'Bitcoin Price: $currentPrice USD',
// style: const TextStyle(fontSize: 24),
// ),
// const SizedBox(width: 10),
// Icon(
// iconUSD,
// color: iconUSD == Icons.arrow_downward
// ? Colors.blue
//     : Colors.red,
// size: 60.0,
// ), // Add the arrow icon and specify the color
// ],
// );
// },
// loading: () => const CircularProgressIndicator(),
// error: (_, __) =>
// const Text('Failed to load bitcoin price in USD.'),
// ),
