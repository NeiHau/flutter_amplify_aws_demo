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
              onPressed: () => checkUserInfo(context),
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
      debugPrint('Error signing out: $e');
    }
  }

  Future<void> checkUserInfo(BuildContext context) async {
    try {
      final user = await Amplify.Auth.getCurrentUser();

      // Use dialog to show user information
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('User Info'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Username: ${user.username}'),
                Text('UserID: ${user.userId}'),
                Text('SignInDetails: ${user.signInDetails}'),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('Failed to get current user: $e');
    }
  }
}
