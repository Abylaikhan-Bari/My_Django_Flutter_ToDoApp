import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  TodoProvider() {
    this.fetchTasks();
  }

  List<Todo> _todos = [];

  List<Todo> get todos {
    return [..._todos];
  }

  Future<void> fetchTasks() async {
    try {
      final url = "http://127.0.0.1:8000/apis/v1/?format=json";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        _todos = jsonData.map<Todo>((json) => Todo.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch tasks');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
