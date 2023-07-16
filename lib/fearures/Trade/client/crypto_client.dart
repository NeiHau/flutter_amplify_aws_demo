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
