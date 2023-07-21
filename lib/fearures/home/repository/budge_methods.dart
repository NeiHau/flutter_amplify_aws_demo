import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../../../models/BudgetEntry.dart';

class BudgeMethods {
  static double calculateTotalBudget(List<BudgetEntry?> items) {
    var totalAmount = 0.0;
    for (final item in items) {
      totalAmount += item?.amount ?? 0;
    }
    return totalAmount;
  }

  static Future<BudgetEntry?> _readBudgetEntry(String entryId) async {
    try {
      final request = ModelQueries.get(
        BudgetEntry.classType,
        BudgetEntryModelIdentifier(id: entryId),
      );
      final response = await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        debugPrint('Failed to get budget entry: ${response.errors}');
        return null;
      }

      final BudgetEntry? budgetEntry = response.data;

      if (budgetEntry != null) {
        debugPrint('Successfully fetched budget entry with id $budgetEntry');
      } else {
        debugPrint('No budget entry found with id $entryId');
      }

      return budgetEntry;
    } on ApiException catch (e) {
      safePrint("Query failed $e");
      return null;
    }
  }

  static void promptForEntryId(BuildContext context) {
    debugPrint('Entering _promptForEntryId');

    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter BudgetEntry ID'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "BudgetEntry ID"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                String id = controller.text;
                Navigator.of(context).pop();
                _readBudgetEntry(id);
              },
            ),
          ],
        );
      },
    );
  }
}
