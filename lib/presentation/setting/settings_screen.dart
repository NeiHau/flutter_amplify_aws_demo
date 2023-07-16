import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: checkUserInfo,
              child: const Text('Get User Info'),
            ),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> checkUserInfo() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      print('User: ${user.username}');
      print('User: ${user.userId}');
      print('User: ${user.signInDetails}');
    } catch (e) {
      print('Failed to get current user: $e');
    }
  }
}
