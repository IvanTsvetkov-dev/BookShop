import 'dart:io';

import 'package:bookshopapp/api/server_api.dart';
import 'package:bookshopapp/api/unauthorized_exception.dart';
import 'package:bookshopapp/models/book.dart';
import 'package:bookshopapp/widgets/book_in_cart_card.dart';
import 'package:flutter/material.dart';
import 'package:bookshopapp/api/globals.dart' as globals;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<Map<Book, int>> cartContentsFuture;

  Future<Map<Book, int>> getCartContentsFromServer() async {
    try {
      final List<Map<String, dynamic>> cartInfo =
          await getCartContents(globals.accesToken);
      final Map<Book, int> result = {};
      if (cartInfo.isEmpty) {
        return result;
      }

      for (var obj in cartInfo) {
        try {
          var book = await getBookById(obj['book_id']);
          result[book] = obj['count'] as int;
        } on HttpException catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to load book ${e.toString()}')));
          }
        }
      }

      return result;
    } on UnauthorizedException catch (e) {
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    cartContentsFuture = getCartContentsFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Basket',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: cartContentsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final cartContents = snapshot.data;

              return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartContents!.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return BookInCartCard(
                      initialCount: 0,
                      book: Book(
                          id: 1,
                          image: '',
                          title: 'War and Peace',
                          author: 'Leo Tolstoy',
                          price: '123',
                          countInStorage: 100),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
