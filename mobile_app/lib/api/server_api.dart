import 'dart:convert';
import 'dart:io';
import 'package:bookshopapp/models/Book.dart';
import 'package:bookshopapp/models/quote.dart';
import 'package:bookshopapp/models/tokens.dart';
import 'package:bookshopapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'globals.dart' as globals;

Future<Response> pingServer(Uri serverUri) {
  return get(serverUri);
}

Future<Tokens> tryAuthenticate(String username, String password) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'auth/jwt/create/');
  final response = await post(serverUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password})).timeout(
    const Duration(seconds: 10),
    onTimeout: () => Response('timeout', HttpStatus.requestTimeout),
  );

  if (response.statusCode == HttpStatus.ok) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    return Tokens(
        access: body['access'] as String, refresh: body['refresh'] as String);
  } else if (response.statusCode == HttpStatus.requestTimeout) {
    throw const HttpException('Request Timeout');
  } else if (response.statusCode == HttpStatus.unauthorized) {
    throw HttpException('Unauthorized ${response.statusCode}');
  } else {
    throw HttpException(
        'Someting went wrong. Http Status Code: ${response.statusCode}');
  }
}

Future<void> tryRegister(User user) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/create_user/');
  final response = await post(serverUri,
          headers: {'Content-Type': 'application/json'}, body: user.toJson())
      .timeout(const Duration(seconds: 10),
          onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode != HttpStatus.created) {
    throw HttpException('${response.statusCode}');
  }
}

Future<Quote> getRandomQuote() async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/random_quote/');
  final response = await get(serverUri).timeout(const Duration(seconds: 10),
      onTimeout: () => Response('timeout', HttpStatus.requestTimeout));

  if (response.statusCode == HttpStatus.ok) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (body['random_quote'] is Map<String, dynamic>) {
      final quoteJson = body['random_quote'] as Map<String, dynamic>;
      final quote = Quote(
          author: quoteJson['author'] as String, text: quoteJson['quote']);
      return quote;
    } else {
      return Quote(author: 'empty', text: 'empty');
    }
  } else {
    throw HttpException('${response.statusCode}');
  }
}

Future<List<Book>> fetchBookList() async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/book');
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
