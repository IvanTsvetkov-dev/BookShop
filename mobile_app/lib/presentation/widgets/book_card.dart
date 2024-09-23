import 'dart:io';

import 'package:bookshopapp/core/cart_contents_controller.dart';
import 'package:bookshopapp/data/models/book.dart';
import 'package:bookshopapp/presentation/pages/book_page.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard(
      {super.key,
      required this.book,
      required this.isInCartInitially,
      required this.cartContentsController});

  final Book book;
  final bool isInCartInitially;
  final CartContentsController cartContentsController;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool addedToCard = false;
  bool addedToFavourites = false;

  IconData getFavouritesIcon() {
    return (addedToFavourites)
        ? Icons.favorite
        : Icons.favorite_border_outlined;
  }

  IconData getAddToCartIcon(bool inCart) {
    return (inCart) ? Icons.check : Icons.add;
  }

  Future<void> addToCartFromRec(int bookId) async {
    try {
      await widget.cartContentsController.add(bookId, 1);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Added to cart')));
      }
      setState(() {
        addedToCard = true;
      });
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
    addedToCard = widget.isInCartInitially;
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color(0xFF39AFEA);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookPage(
                      book: widget.book,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.book.image,
              width: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return FractionallySizedBox(
                  heightFactor: 1.0,
                  child: SizedBox(
                    width: 50,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[300])),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(widget.book.author,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12)),
                    Text('${widget.book.price}\$',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color.fromARGB(56, 0, 0, 0)))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          addedToFavourites = !addedToFavourites;
                        });
                      },
                      icon: Icon(
                        getFavouritesIcon(),
                        color: iconColor,
                      )),
                  ListenableBuilder(
                    listenable: widget.cartContentsController,
                    builder: (context, child) {
                      final inCart = widget.cartContentsController
                          .hasBookWithId(widget.book.id);

                      return IconButton(
                          onPressed: (!inCart)
                              ? () {
                                  addToCartFromRec(widget.book.id);
                                }
                              : null,
                          icon: Icon(
                            getAddToCartIcon(inCart),
                            color: (inCart) ? Colors.grey : iconColor,
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
