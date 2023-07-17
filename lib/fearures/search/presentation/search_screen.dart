import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../../../models/Reservation.dart'; // ここでReservationクラスをインポート

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  Future<void> _createReservation() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    // If the form is valid, create a new reservation
    final name = _nameController.text;
    final date = _dateController.text;

    try {
      final newEntry = Reservation(name: name, date: date);

      final request = ModelMutations.create(newEntry);
      final response = await Amplify.API.mutate(request: request).response;

      safePrint('Create result: $response');
    } catch (e) {
      debugPrint('Save failed: ${e.toString()}');
    } finally {
      _nameController.clear();
      _dateController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
              ),
              ElevatedButton(
                onPressed: _createReservation,
                child: const Text('Create Reservation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
