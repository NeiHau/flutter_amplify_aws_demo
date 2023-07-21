import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/User.dart';

class BitCoinScreen extends ConsumerStatefulWidget {
  const BitCoinScreen({Key? key}) : super(key: key);

  @override
  BitCoinScreenState createState() => BitCoinScreenState();
}

class BitCoinScreenState extends ConsumerState<BitCoinScreen> {
  late var _userEntries = <User>[];

  @override
  void initState() {
    super.initState();
    _refreshUserEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // Navigate to the page to create new budget entries
        onPressed: () => _navigateToUserEntry(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RefreshIndicator(
            onRefresh: _refreshUserEntries,
            child: Column(
              children: [
                if (_userEntries.isEmpty)
                  const Text('Use the \u002b sign to add new budget entries')
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Show total budget from the list of all BudgetEntries
                      Text(
                        'Total Budget',
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                const SizedBox(height: 30),
                _buildRow(
                  name: 'Title',
                  age: 0,
                  gender: 'Amount',
                  assets: 0,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _userEntries.length,
                    itemBuilder: (context, index) {
                      final userEntry = _userEntries[index];
                      return Dismissible(
                        key: ValueKey(userEntry),
                        background: const ColoredBox(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                        onDismissed: (_) => _deleteUserEntry(userEntry),
                        child: ListTile(
                          onTap: () => _navigateToUserEntry(
                            context,
                            userEntry: userEntry,
                          ),
                          title: _buildRow(
                            name: userEntry.name,
                            age: userEntry.age ?? 0,
                            gender: userEntry.gender,
                            assets: userEntry.assets,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToUserEntry(BuildContext context,
      {User? userEntry}) async {
    await context.pushNamed('crypto', extra: userEntry);
    // Refresh the entries when returning from the
    // budget entry screen.
    await _refreshUserEntries();
  }

  Future<void> _refreshUserEntries() async {
    try {
      final request = ModelQueries.list(User.classType);
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }
      if (mounted) {
        setState(() {
          _userEntries = todos!.whereType<User>().toList();
        });
      }
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  Future<void> _deleteUserEntry(User userEntry) async {
    final request = ModelMutations.delete<User>(userEntry);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Delete response: $response');
    await _refreshUserEntries();
  }

  Widget _buildRow({
    required String name,
    required int age,
    required String gender,
    required double assets,
    TextStyle? style,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            age.toString(),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            gender,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            assets.toString(),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ],
    );
  }
}
