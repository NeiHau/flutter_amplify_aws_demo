import 'package:flutter_amplify_awsdemo/common/app_key.dart';
import 'package:go_router/go_router.dart';

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
    ],
  );
}
