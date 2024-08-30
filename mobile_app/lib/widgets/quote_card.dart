import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
      child: Column(
        children: [
          Text(
            'Quote of the day',
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
