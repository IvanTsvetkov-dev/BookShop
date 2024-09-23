import 'dart:convert';
import 'dart:io';

import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/data/models/book.dart';
import 'package:http/http.dart';

abstract class IBooksRepo {
  Future<List<Book>> fetchRecBookList();
  Future<Book> getBookById(int id);
}

class BooksRepo implements IBooksRepo {

  @override
  Future<List<Book>> fetchRecBookList() async {
    final Uri serverUri = Uri.http(AppEnviroment.serverHost, 'api/v1/book/');
    final response = await get(serverUri).timeout(const Duration(seconds: 10),
        onTimeout: () => Response('timeout', HttpStatus.requestTimeout));

    final List<Book> result = List.empty(growable: true);

    if (response.statusCode == HttpStatus.ok) {
      final body = jsonDecode(response.body) as List<dynamic>;
      for (dynamic element in body) {
        final bookJson = element as Map<String, dynamic>;
        final book = Book(
            id: bookJson['id'],
            title: bookJson['title'],
            author: bookJson['author'],
            image: bookJson['image'],
            price: bookJson['price'],
            countInStorage: bookJson['count_in_storage']);
        result.add(book);
      }
      return result;
    } else {
      throw HttpException('${response.statusCode}');
    }
  }
  
  @override
  Future<Book> getBookById(int id) async {
  final Uri serverUri = Uri.http(AppEnviroment.serverHost, 'api/v1/book/$id/');
  final response = await get(serverUri).timeout(const Duration(seconds: 10),
      onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode == HttpStatus.ok) {
    final bookJson = jsonDecode(response.body) as Map<String, dynamic>;
    return Book(
        id: id,
        title: bookJson['title'],
        author: bookJson['author'],
        image: bookJson['image'],
        price: bookJson['price'],
        countInStorage: bookJson['count_in_storage']);
  } else {
    throw HttpException('Error Code ${response.statusCode}');
  }
}
}
