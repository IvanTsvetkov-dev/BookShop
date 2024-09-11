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
  Map<Book, int> loadedContents = {};
  Map<Book, int> selectedBooks = {};

  Future<Map<Book, int>> getCartContentsFromServer() async {
    try {
      final List<Map<String, dynamic>> cartInfo =
          await getCartContents(globals.accessToken);
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

  double calculateOverall() {
    var overrall = 0.0;
    for (var book in selectedBooks.keys) {
      final bookPrice = double.tryParse(book.price);
      overrall += (bookPrice != null && selectedBooks[book] != null)
          ? bookPrice * selectedBooks[book]!
          : 0.0;
    }
    return overrall;
  }

  void onBookCountChanged(Book book, int count) {
    if (selectedBooks.containsKey(book)) {
      setState(() {
        selectedBooks[book] = count;
      });
    }
  }

  void onBookSelected(Book book, bool selected, int count) {
    if (selected) {
      setState(() {
        selectedBooks[book] = count;
      });
    } else {
      setState(() {
        selectedBooks.remove(book);
      });
    }
  }

  Future<void> deleteBookFromCart(Book book) async {
    try {
      final bool? delete = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Confirm'),
                content: const Text(
                    'Are you sure you want to delete this book from your basket?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'))
                ]);
          });
      if (delete != null && delete) {
        await deleteFromCart(book.id);
        setState(() {
          loadedContents.remove(book);
          selectedBooks.remove(book);
        });
      }
    } on HttpException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cartContentsFuture = getCartContentsFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FutureBuilder(
              future: cartContentsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var cartContents = snapshot.data;
                  if (loadedContents.isEmpty) {
                    loadedContents = (cartContents != null) ? cartContents : {};
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: loadedContents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final book = loadedContents.keys.toList()[index];
                        return BookInCartCard(
                            countChangedCallback: onBookCountChanged,
                            selectCallback: onBookSelected,
                            deleteCallback: deleteBookFromCart,
                            initialCount: loadedContents[book]!,
                            book: book);
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Visibility(
              visible: selectedBooks.isNotEmpty,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.20,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_grocery_store,
                            color: Colors.white,
                          ),
                          Text(
                            'Total selected price: ${calculateOverall()}\$',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Text(
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF4F4FB),
                                    fontSize: 30),
                                'Place order')),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
