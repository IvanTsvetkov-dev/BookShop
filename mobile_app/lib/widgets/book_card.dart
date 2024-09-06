import 'package:bookshopapp/api/constants.dart' as constants;
import 'package:bookshopapp/models/Book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, required this.book});

  final Book book;

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

  IconData getAddToCartIcon() {
    return (addedToCard) ? Icons.check : Icons.add;
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color(0xFF39AFEA);
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            Uri(
                    scheme: 'https',
                    host: constants.serverHost,
                    path: widget.book.image)
                .toString(),
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
                IconButton(
                    onPressed: () {
                      setState(() {
                        addedToCard = !addedToCard;
                      });
                    },
                    icon: Icon(
                      getAddToCartIcon(),
                      color: iconColor,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
