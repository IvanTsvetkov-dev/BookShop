import 'package:bookshopapp/models/book.dart';
import 'package:flutter/material.dart';

class BookInCartCard extends StatefulWidget {
  const BookInCartCard(
      {super.key, required this.initialCount, required this.book});

  final int initialCount;
  final Book book;

  @override
  State<BookInCartCard> createState() => _BookInCartCardState();
}

class _BookInCartCardState extends State<BookInCartCard> {
  bool checkboxValue = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: SizedBox(
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                value: checkboxValue,
                onChanged: (bool? value) {
                  setState(() {
                    checkboxValue = value!;
                  });
                }),
            SizedBox(
              width: 80,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[300])),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Text(
                                widget.book.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.close,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                            ],
                          ),
                        )),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            widget.book.author,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(widget.book.price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color.fromARGB(56, 0, 0, 0))),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 35,
                              child: Material(
                                color: Colors.white,
                                child: Center(
                                  child: Ink(
                                    width: 50,
                                    height: 50,
                                    decoration: const ShapeDecoration(
                                      color: Color.fromARGB(58, 94, 105, 238),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                    ),
                                    child: IconButton(
                                      iconSize: 14,
                                      icon: const Icon(Icons.remove),
                                      color: Colors.black,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text('$count',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 40,
                              width: 35,
                              child: Material(
                                color: Colors.white,
                                child: Center(
                                  child: Ink(
                                    width: 50,
                                    height: 50,
                                    decoration: const ShapeDecoration(
                                      color: Color.fromARGB(58, 94, 105, 238),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                    ),
                                    child: IconButton(
                                      iconSize: 14,
                                      icon: const Icon(Icons.add),
                                      color: Colors.black,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
