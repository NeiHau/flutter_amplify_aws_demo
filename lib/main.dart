import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_awsdemo/routing/go_router.dart';
import 'package:flutter_amplify_awsdemo/utils/amplifyconfiguration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'models/ModelProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> _configureAmplify() async {
  try {
    // Create the API plugin.
    //
    // If `ModelProvider.instance` is not available, try running
    // `amplify codegen models` from the root of your project.
    final api = AmplifyAPI(
        modelProvider: ModelProvider.instance); // Create the Auth plugin.
    final auth = AmplifyAuthCognito();

    // Add the plugins and configure Amplify for your app.
    await Amplify.addPlugins([api, auth]);
    await Amplify.configure(amplifyconfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

final logger = Logger(
  level: Level.info,
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: !Platform.isIOS,
    // iOSで色をつけると表示が崩れるため
    printEmojis: false,
    printTime: false,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: GoRouterManager.router,
        debugShowCheckedModeBanner: false,
        builder: Authenticator.builder(),
      ),
    );
  }
}
