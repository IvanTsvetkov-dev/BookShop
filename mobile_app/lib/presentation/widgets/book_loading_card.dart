import 'package:flutter/material.dart';

class BookLoadingCard extends StatelessWidget {
  const BookLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color(0xFF39AFEA);
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 50,
            child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[300])),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                    width: 100,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[300])),
                  ),
                  SizedBox(
                    height: 15,
                    width: 70,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[300])),
                  ),
                  SizedBox(
                    height: 15,
                    width: 30,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[300])),
                  )
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
