import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchNews() async {
  final response = await http.get(
    Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=61a93734aebb476aa0a108a241481959'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> map = jsonDecode(response.body);
    return map["articles"];
  } else {
    throw Exception('Failed to fetch news');
  }
}
