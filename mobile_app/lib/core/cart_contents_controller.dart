import 'dart:io';

import 'package:bookshopapp/api%5Blegacy%5D/server_api.dart';
import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/data/models/book.dart';
import 'package:flutter/material.dart';

class CartContentsController extends ChangeNotifier {
  Map<Book, int> loadedContents = {};
  static final CartContentsController _instance =
      CartContentsController._internal();

  factory CartContentsController() {
    return _instance;
  }

  CartContentsController._internal();

  Future<void> initContents() async {
    final List<Map<String, dynamic>> cartInfo =
        await getCartContents(AppEnviroment.tokens.access);
    final Map<Book, int> result = {};
    if (cartInfo.isEmpty) {
      return;
    }

    for (var obj in cartInfo) {
      var book = await getBookById(obj['book_id']);
      result[book] = obj['count'] as int;
    }

    loadedContents = result;
    notifyListeners();
  }

  Future<void> remove(Book book) async {
    await deleteFromCart(book.id);
    loadedContents.removeWhere((key, value) => key.id == book.id,);
    notifyListeners();
  }

  Future<void> add(int bookId, int count) async {
    await addToCart(bookId, count);
    initContents();
  }

  bool hasBookWithId(int bookId) {
    for (var book in loadedContents.keys) {
      if (book.id == bookId) {
        return true;
      }
    }
    return false;
  }
}
