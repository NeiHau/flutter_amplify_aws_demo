import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_awsdemo/common/app_key.dart';

import '../../../models/BudgetEntry.dart';

// 検索絞り込み条件のカテゴリ
enum FilteredBy { id, title }

class BudgeMethods {
  static double calculateTotalBudget(List<BudgetEntry?> items) {
    var totalAmount = 0.0;
    for (final item in items) {
      totalAmount += item?.amount ?? 0;
    }
    return totalAmount;
  }

  static void promptForEntryId() {
    final controller = TextEditingController();
    FilteredBy? filteredBy = FilteredBy.id;

    showDialog(
      context: AppKey.navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Enter BudgetEntry ID or Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('ID'),
                  leading: Radio(
                    value: FilteredBy.id,
                    groupValue: filteredBy,
                    onChanged: (FilteredBy? value) {
                      setState(() {
                        filteredBy = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Title'),
                  leading: Radio(
                    value: FilteredBy.title,
                    groupValue: filteredBy,
                    onChanged: (FilteredBy? value) {
                      setState(() {
                        filteredBy = value;
                      });
                    },
                  ),
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: filteredBy == FilteredBy.id
                        ? "BudgetEntry ID"
                        : "BudgetEntry Title",
                  ),
                ),
              ],
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
                  String searchQuery = controller.text;
                  Navigator.of(context).pop();
                  if (filteredBy == FilteredBy.id) {
                    _readBudgetEntry(searchQuery);
                  } else if (filteredBy == FilteredBy.title) {
                    _readBudgetEntriesByTitle(searchQuery);
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  // IDで検索
  // get() -> 今のところIDのみでしかフィルターをかけられない。
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

  // Titleで検索
  // list() -> ID以外のプロパティでフィルターをかけることができる。
  static Future<List<BudgetEntry?>?> _readBudgetEntriesByTitle(
      String title) async {
    try {
      final request = ModelQueries.list(
        BudgetEntry.classType,
        where: BudgetEntry.TITLE.contains(title),
      );
      final response = await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        debugPrint('Failed to get budget entries: ${response.errors}');
        return null;
      }

      final List<BudgetEntry?> budgetEntries = response.data?.items ?? [];

      for (final entry in budgetEntries) {
        if (entry != null) {
          debugPrint('Successfully fetched budget entry with Title $entry');
        } else {
          debugPrint('No budget entry found with title $title');
        }
      }

      return budgetEntries;
    } on ApiException catch (e) {
      safePrint("Query failed $e");
      return null;
    }
  }
}
