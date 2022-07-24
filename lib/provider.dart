// ignore_for_file: avoid_print, depend_on_referenced_packages, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:api_state/models/detail_book.dart';
import 'package:api_state/models/list_book.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  ListBook? listbook;
  getlistdata() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      listbook = ListBook.fromJson(json); 
    }
    notifyListeners();
  }

  DetailBook? detailBook;
  getDetailBook(String isbn13) async {
    detailBook = null;
    var url = Uri.parse("https://api.itbook.store/1.0/books/${isbn13}");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      detailBook = DetailBook.fromJson(json);
    }
    notifyListeners();
  }
}
