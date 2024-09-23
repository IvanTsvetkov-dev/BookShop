import 'dart:io';

import 'package:bookshopapp/api/cart_contents_controller.dart';
import 'package:bookshopapp/models/book.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.book});

  final Book book;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  CartContentsController cartContentsController = CartContentsController();

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
        await cartContentsController.remove(book);
      }
    } on HttpException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } on SocketException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 230,
            child: Swiper(
              itemBuilder: (context, index) {
                return Image.network(
                  widget.book.image,
                  errorBuilder: (context, error, stackTrace) {
                    return FractionallySizedBox(
                      heightFactor: 1.0,
                      child: SizedBox(
                        width: 160,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey[300])),
                      ),
                    );
                  },
                );
              },
              itemCount: 3,
              viewportFraction: 0.5,
              scale: 0.9,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.book.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              )
            ],
          ),
          Text(
            widget.book.author,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text('4,7')
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Text('Lorem ipsum'),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListenableBuilder(
                listenable: cartContentsController,
                builder: (context, child) {
                  if (cartContentsController.hasBookWithId(widget.book.id)) {
                    return ElevatedButton(
                      onPressed: () async {
                        await deleteBookFromCart(widget.book);
                        setState(() {
                          
                        });
                      },
                      child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Text(
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF4F4FB),
                                  fontSize: 30),
                              'Remove from cart')),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      cartContentsController.add(widget.book.id, 1);
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: Text(
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF4F4FB),
                                fontSize: 30),
                            'Add to cart ${widget.book.price}\$')),
                  );
                }),
          )
        ],
      ),
    );
  }
}
