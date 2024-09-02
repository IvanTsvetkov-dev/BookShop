import 'dart:convert';
import 'package:bookshopapp/models/Book.dart';
import 'package:bookshopapp/models/user.dart';
import 'package:http/http.dart';
import 'constants.dart' as constants;

Future<Response> pingServer(Uri serverUri) {
  return get(serverUri);
}

Future<Response> tryAuthenticate(String username, String password) {
  final Uri serverUri =
      Uri(scheme: 'https', host: constants.serverHost, path: 'api/token/');
  return post(serverUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}));
}

Future<Response> tryRegister(User user) {
  final Uri serverUri = Uri(
      scheme: 'https', host: constants.serverHost, path: 'api/create_user/');
  return post(serverUri,
      headers: {'Content-Type': 'application/json'}, body: user.toJson());
}

Future<Response> fetchBookList(){
  final Uri serverUri = Uri(
      scheme: 'https', host: constants.serverHost, path: 'api/books_list/');
  return get(serverUri); 
}

