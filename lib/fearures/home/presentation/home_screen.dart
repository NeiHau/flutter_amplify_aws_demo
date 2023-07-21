import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/BudgetEntry.dart';
import '../repository/budge_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late var _budgetEntries = <BudgetEntry>[];

  @override
  void initState() {
    super.initState();
    _refreshBudgetEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToBudgetEntry(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.pushNamed('search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => BudgeMethods.promptForEntryId(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RefreshIndicator(
            onRefresh: _refreshBudgetEntries,
            child: Column(
              children: [
                if (_budgetEntries.isEmpty)
                  const Text('Use the \u002b sign to add new budget entries')
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Show total budget from the list of all BudgetEntries
                      Text(
                        'Total Budget: \$ ${BudgeMethods.calculateTotalBudget(_budgetEntries).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                const SizedBox(height: 30),
                _buildRow(
                  title: 'Title',
                  description: 'Description',
                  amount: 'Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _budgetEntries.length,
                    itemBuilder: (context, index) {
                      final budgetEntry = _budgetEntries[index];
                      return Dismissible(
                        key: ValueKey(budgetEntry),
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
                        onDismissed: (_) => _deleteBudgetEntry(budgetEntry),
                        child: ListTile(
                          onTap: () => _navigateToBudgetEntry(
                            context,
                            budgetEntry: budgetEntry,
                          ),
                          title: _buildRow(
                            title: budgetEntry.title,
                            description: budgetEntry.description ?? '',
                            amount:
                                '\$ ${budgetEntry.amount.toStringAsFixed(2)}',
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

  Future<void> _refreshBudgetEntries() async {
    try {
      final request = ModelQueries.list(BudgetEntry.classType);
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }
      if (mounted) {
        setState(() {
          _budgetEntries = todos!.whereType<BudgetEntry>().toList();
        });
      }
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  Future<void> _deleteBudgetEntry(BudgetEntry budgetEntry) async {
    final request = ModelMutations.delete<BudgetEntry>(budgetEntry);
    final response = await Amplify.API.mutate(request: request).response;

    safePrint('Delete response: $response');

    await _refreshBudgetEntries();
  }

  Future<void> _navigateToBudgetEntry(BuildContext context,
      {BudgetEntry? budgetEntry}) async {
    await context.pushNamed('manage', extra: budgetEntry);

    await _refreshBudgetEntries();
  }

  Widget _buildRow({
    required String title,
    required String description,
    required String amount,
    TextStyle? style,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            amount,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ],
    );
  }
}
