import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_awsdemo/models/ModelProvider.dart';
import 'package:go_router/go_router.dart';

class UserCryptoEntryScreen extends StatefulWidget {
  const UserCryptoEntryScreen({required this.user, super.key});

  final User? user;

  @override
  State<UserCryptoEntryScreen> createState() => _UserCryptoEntryScreenState();
}

class _UserCryptoEntryScreenState extends State<UserCryptoEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _assetsController = TextEditingController();

  late final String _titleText;

  bool get _isCreate => _userEntry == null;
  User? get _userEntry => widget.user;

  @override
  void initState() {
    super.initState();

    final userEntry = _userEntry;
    if (userEntry != null) {
      _nameController.text = userEntry.name;
      _ageController.text = userEntry.age.toString() ?? '';
      _genderController.text = userEntry.gender.toString();
      _assetsController.text = userEntry.assets.toString();

      _titleText = 'Update user entry';
    } else {
      _titleText = 'Create user entry';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _assetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Enter age',
                      ),
                    ),
                    TextFormField(
                      controller: _genderController,
                      decoration: const InputDecoration(
                        labelText: 'Enter gender',
                      ),
                    ),
                    TextFormField(
                      controller: _assetsController,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Enter assets',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text(_titleText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // If the form is valid, submit the data
    final name = _nameController.text;
    final age = int.parse(_ageController.text);
    final gender = _genderController.text;
    final assets = double.parse(_assetsController.text);

    if (_isCreate) {
      // Create a new budget entry
      final newEntry = User(
        name: name,
        age: age,
        gender: gender,
        assets: assets,
      );

      final request = ModelMutations.create(newEntry);
      final response = await Amplify.API.mutate(request: request).response;

      safePrint('Create result: $response');
    } else {
      // Update budgetEntry instead
      final updateBudgetEntry = _userEntry!.copyWith(
        name: name,
        age: age,
        gender: gender,
        assets: assets,
      );

      final request = ModelMutations.update(updateBudgetEntry);
      final response = await Amplify.API.mutate(request: request).response;

      safePrint('Update result: $response');
    }

    // Navigate back to homepage after create/update executes
    if (mounted) {
      context.pop();
    }
  }
}
