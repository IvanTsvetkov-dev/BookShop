import 'dart:convert';
import 'package:bookshopapp/models/Book.dart';
import 'package:bookshopapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'constants.dart' as constants;

String serverHost = '';

Future<Response> pingServer(Uri serverUri) {
  return get(serverUri);
}

Future<Response> tryAuthenticate(String username, String password) {
  final Uri serverUri =
      Uri.http(serverHost, 'api/token/');
  debugPrint(serverUri.toString());
  return post(serverUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}));
}

Future<Response> tryRegister(User user) {
  final Uri serverUri = Uri(
      scheme: 'https', host: serverHost, path: 'api/create_user/');
  return post(serverUri,
      headers: {'Content-Type': 'application/json'}, body: user.toJson());
}

Future<Response> fetchBookList(){
  final Uri serverUri = Uri.http(serverHost, 'book/list');
  return get(serverUri); 
}

