import 'dart:convert';
import 'dart:io';

import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/data/models/quote.dart';
import 'package:http/http.dart';

abstract class IQuoteRepo {
  Future<Quote> getRandomQuote();
}

class QuoteRepo implements IQuoteRepo {
  @override
  Future<Quote> getRandomQuote() async {
    final Uri serverUri =
        Uri.http(AppEnviroment.serverHost, 'api/v1/random_quote/');
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
}
