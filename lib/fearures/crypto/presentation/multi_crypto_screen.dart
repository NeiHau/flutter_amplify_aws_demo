import 'package:flutter/material.dart';

import 'crypto_page.dart';
import 'crypto_screen.dart';

class MultiBitCoinScreen extends StatelessWidget {
  const MultiBitCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(flex: 2, child: BitCoinScreen()),
        Divider(height: 10),
        Expanded(child: CryptoScreen()),
      ],
    );
  }
}
