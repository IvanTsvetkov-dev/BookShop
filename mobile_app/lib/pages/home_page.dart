import 'package:bookshopapp/widgets/book_card.dart';
import 'package:bookshopapp/widgets/quote_card.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final leningrad = ['WWW ЛЕНИНГРАД', 'WWW ТОЧКА РУ', 'WWW LENINGRAD'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            )),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favourites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: TextField(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search,
                                color: Theme.of(context).colorScheme.primary),
                            contentPadding: const EdgeInsets.all(5),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3.0),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Search for book',
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      height: 180,
                      child: Swiper(
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Color(0xFF39AFEA),
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return const QuoteCard(
                            text: 'Test',
                            author: 'Vanya Cvetkov',
                          );
                        },
                        itemCount: 2,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const FractionallySizedBox(
              widthFactor: 1.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  'Recomended',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return BookCard(
                      bookAuthor: '$index# Author',
                      bookTitle: '$index# Title',
                      price: 2.0 * index.toDouble(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
