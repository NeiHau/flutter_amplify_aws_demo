import 'package:flutter/material.dart';

import 'crypto_page.dart';
import 'crypto_screen.dart';

class MultiBitCoinScreen extends StatelessWidget {
  const MultiBitCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: BitCoinScreen()),
        Expanded(child: CryptoScreen()),
      ],
    );
  }
}
