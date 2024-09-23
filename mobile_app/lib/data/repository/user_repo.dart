import 'dart:convert';
import 'dart:io';

import 'package:bookshopapp/core/exception/unauthorized_exception.dart';
import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/data/models/tokens.dart';
import 'package:bookshopapp/data/models/user.dart';
import 'package:http/http.dart';

abstract class IUserRepo {
  Future<String> updateAccessToken(String refreshToken);
  Future<Tokens> tryAuthenticate(String username, String password);
  Future<void> tryCreate(User user);
}

class UserRepo implements IUserRepo {
  @override
  Future<String> updateAccessToken(String refreshToken) async {
    final Uri serverUri =
        Uri.http(AppEnviroment.serverHost, 'auth/jwt/refresh/');
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

  @override
  Future<Tokens> tryAuthenticate(String username, String password) async {
    final Uri serverUri =
        Uri.http(AppEnviroment.serverHost, 'auth/jwt/create/');
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

  @override
  Future<void> tryCreate(User user) async {
    final Uri serverUri =
        Uri.http(AppEnviroment.serverHost, 'api/v1/create_user/');
    final response = await post(serverUri,
            headers: {'Content-Type': 'application/json'}, body: user.toJson())
        .timeout(const Duration(seconds: 10),
            onTimeout: () => Response('timeout', HttpStatus.requestTimeout));
    if (response.statusCode != HttpStatus.created) {
      throw HttpException('${response.statusCode}');
    }
  }
}
