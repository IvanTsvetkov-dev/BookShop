import 'package:bookshopapp/api%5Blegacy%5D/server_api.dart';
import 'package:bookshopapp/data/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  late Future<Quote> randomQuote;

  @override
  void initState() {
    randomQuote = getRandomQuote();
    super.initState();
  }

  Widget buildLoadinQuote() {
    return Column(
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
              child: SizedBox(
                width: 60,
                height: 60,
                child: Lottie.asset('assets/quote_anim.json'),
              ),
            ),
            SizedBox(
              height: 15,
              width: 100,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[300])),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            height: 15,
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 15,
              width: 60,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[300])),
            ),
          ),
        )
      ],
    );
  }

  Widget buildQuote(Quote quote) {
    return Column(
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
              child: SizedBox(
                width: 70,
                height: 70,
                child: Lottie.asset('assets/quote_anim.json'),
              ),
            ),
            Text(quote.text,
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
            child: Text(quote.author,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 200,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
      child: FutureBuilder(
        future: randomQuote,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final quote = snapshot.data as Quote;
            return buildQuote(quote);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error appeared'),
            );
          } else {
            return buildLoadinQuote();
          }
        },
      ),
    );
  }
}
