import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key, required this.text, required this.author});

  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                'Quote of the day',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Placeholder(
                  fallbackWidth: 60,
                  fallbackHeight: 60,
                ),
              ),
              Text(text,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15))
            ],
          ),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(author,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }
}
