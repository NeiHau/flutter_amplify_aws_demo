import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplify_awsdemo/common/app_key.dart';
import 'package:go_router/go_router.dart';

import '../fearures/authentication/login/login_screen.dart';
import '../fearures/authentication/signup/presentation/signup_screen.dart';
import '../fearures/crypto/presentation/user_crypto_entry_screen.dart';
import '../fearures/home/presentation/component/manage_Budge_Entry_screen.dart';
import '../fearures/search/presentation/search_screen.dart';
import '../initial_screen.dart';
import '../models/BudgetEntry.dart';
import '../models/User.dart';

class GoRouterManager {
  // GoRouter configuration
  static final router = GoRouter(
    navigatorKey: AppKey.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const InitialScreen(),
      ),
      GoRoute(
        path: '/manage-budget-entry',
        name: 'manage',
        builder: (context, state) => ManageBudgetEntryScreen(
          budgetEntry: state.extra as BudgetEntry?,
        ),
      ),
      GoRoute(
        path: '/crypto-screen-entry',
        name: 'crypto',
        builder: (context, state) => UserCryptoEntryScreen(
          user: state.extra as User?,
        ),
      ),
      GoRoute(
        path: '/search-screen',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/confirmation',
        builder: (context, state) => const ConfirmScreen(),
      ),
    ],
    redirect: (context, state) async {
      final authState = await Amplify.Auth.fetchAuthSession();

      if (!authState.isSignedIn) {
        return '/signup';
      }

      return null;
    },
  );
}
