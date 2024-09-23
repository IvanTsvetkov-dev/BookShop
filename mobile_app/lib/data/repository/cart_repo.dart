import 'dart:convert';
import 'dart:io';

import 'package:bookshopapp/core/exception/unauthorized_exception.dart';
import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:http/http.dart';

abstract class ICartRepo {
  Future<void> editCartContents(int bookId, int count);
  Future<void> addToCart(int bookId, int count);
  Future<List<Map<String, dynamic>>> getCartContents(String accessToken);
}

class CartRepo implements ICartRepo {
  @override
  Future<void> editCartContents(int bookId, int count) async {
    final Uri serverUri =
        Uri.http(AppEnviroment.serverHost, 'api/v1/basket/$bookId/');

    final response = await patch(serverUri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AppEnviroment.tokens.access}'
            },
            body: jsonEncode({'book_id': bookId, 'count': count}))
        .timeout(const Duration(seconds: 10),
            onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('Error Code ${response.statusCode}');
    }
  }

  @override
  Future<void> addToCart(int bookId, int count) async {
    final Uri serverUri = Uri.http(AppEnviroment.serverHost, 'api/v1/basket/');

    final response = await post(serverUri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AppEnviroment.tokens.access}'
            },
            body: jsonEncode({'book_id': bookId, 'count': count}))
        .timeout(const Duration(seconds: 10),
            onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
    if (response.statusCode != HttpStatus.created) {
      throw HttpException('Error Code ${response.statusCode}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getCartContents(String accessToken) async {
    final Uri serverUri = Uri.http(AppEnviroment.serverHost, 'api/v1/basket/');
    final List<Map<String, dynamic>> result = List.empty(growable: true);

    final response = await get(serverUri,
            headers: {'Authorization': 'Bearer $accessToken'})
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
}
