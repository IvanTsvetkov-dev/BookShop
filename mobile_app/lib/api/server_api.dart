import 'dart:convert';
import 'dart:io';
import 'package:bookshopapp/api/unauthorized_exception.dart';
import 'package:bookshopapp/models/book.dart';
import 'package:bookshopapp/models/quote.dart';
import 'package:bookshopapp/models/tokens.dart';
import 'package:bookshopapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

Future<Response> pingServer(Uri serverUri) {
  return get(serverUri);
}

Future<String> updateAccessToken(String refreshToken) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'auth/jwt/refresh/');
  final response = await post(serverUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken})).timeout(
    const Duration(seconds: 10),
    onTimeout: () => Response('timeout', HttpStatus.requestTimeout),
  );
  if (response.statusCode == HttpStatus.ok) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['access'] as String;
  } else {
    throw UnauthorizedException('Error Code ${response.statusCode}');
  }
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

Future<List<Map<String, dynamic>>> getCartContents(String accessToken) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/basket/');
  final List<Map<String, dynamic>> result = List.empty(growable: true);

  final response =
      await get(serverUri, headers: {'Authorization': 'Bearer $accessToken'})
          .timeout(const Duration(seconds: 10),
              onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode == HttpStatus.ok) {
    // debugPrint(response.body);
    // debugPrint(globals.accesToken);
    final listJson = jsonDecode(response.body) as List<dynamic>;
    for (var objJson in listJson) {
      final obj = objJson as Map<String, dynamic>;
      result.add(obj);
    }
    return result;
  } else if (response.statusCode == HttpStatus.unauthorized) {
    throw const UnauthorizedException('');
  } else {
    throw HttpException('Error Code ${response.statusCode}');
  }
}

Future<Book> getBookById(int id) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/book/$id/');
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

Future<void> deleteFromCart(int bookId) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/basket/$bookId/');

  final response = await delete(
    serverUri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${globals.accessToken}'
    },
  ).timeout(const Duration(seconds: 10),
      onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode != HttpStatus.noContent) {
    throw HttpException('Error Code ${response.statusCode}');
  }
}

Future<void> editCartContents(int bookId, int count) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/basket/$bookId/');

  final response = await patch(serverUri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${globals.accessToken}'
          },
          body: jsonEncode({'book_id': bookId, 'count': count}))
      .timeout(const Duration(seconds: 10),
          onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode != HttpStatus.ok) {
    throw HttpException('Error Code ${response.statusCode}');
  }
}

Future<void> addToCart(int bookId, int count) async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/basket/');

  final response = await post(serverUri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${globals.accessToken}'
          },
          body: jsonEncode({'book_id': bookId, 'count': count}))
      .timeout(const Duration(seconds: 10),
          onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
  if (response.statusCode != HttpStatus.created) {
    throw HttpException('Error Code ${response.statusCode}');
  }
}

Future<List<Book>> fetchBookList() async {
  final Uri serverUri = Uri.http(globals.serverHost, 'api/v1/book/');
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
