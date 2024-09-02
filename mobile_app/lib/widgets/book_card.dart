import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard(
      {super.key,
      required this.bookAuthor,
      required this.bookTitle,
      required this.price});

  final String bookAuthor;
  final String bookTitle;
  final double price;

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color(0xFF39AFEA);
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Placeholder(
            fallbackWidth: 50,
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
                    bookTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Text(bookAuthor,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12)),
                  Text('$price\$',
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: iconColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
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
