import 'dart:convert';
import 'dart:io';

import 'package:bookshopapp/api/server_api.dart';
import 'package:bookshopapp/models/Book.dart';
import 'package:bookshopapp/models/quote.dart';
import 'package:bookshopapp/widgets/book_card.dart';
import 'package:bookshopapp/widgets/book_loading_card.dart';
import 'package:bookshopapp/widgets/quote_card.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef WidgetBuilder = Widget Function();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<WidgetBuilder> pages = List.empty(growable: true);
  List<String> titles = ['Home', 'Favourites', 'Account'];

  late Future<List<Book>> futureBookList;

  @override
  void initState() {
    pages.add(buildHomePage);
    pages.add(buildFavouritesPage);
    pages.add(buildAccountPage);
    futureBookList = fetchBookList();
    super.initState();
  }
  /*
  Future<List<Book>> tryParseBooks() async {
    final Response response = await fetchBookList();
    final List<Book> result = List.empty(growable: true);

    if (response.statusCode == HttpStatus.ok) {
      // debugPrint(response.body);
      final body = jsonDecode(response.body) as List<dynamic>;
      for (dynamic element in body) {
        final bookJson = element as Map<String, dynamic>;
        final book = Book(
            id: bookJson['id'],
            title: bookJson['title'],
            author: bookJson['author'],
            image: bookJson['image'],
            price: bookJson['price'],
            countInStorage: bookJson['count_in_storage']);
        result.add(book);
      }
      return result;
    } else {
      return List.empty();
    }
  }*/

  List<Widget>? getPageActions(int index) {
    switch (index) {
      case 0:
        return [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ))
        ];
      case 1:
        return null;
      case 2:
        return [
          IconButton(
              onPressed: logOutPressed,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ];
    }
  }

  logOutPressed() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', '');
    prefs.setString('access_token', '');
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/greetings');
    }
  }

  Widget buildFavouritesPage() {
    return const Center(child: Text('There will be favouritesPage'));
  }

  Widget buildAccountPage() {
    return const Center(child: Text('There will be account'));
  }

  Widget buildHomePage() {
    return SingleChildScrollView(
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
                          color: Color.fromARGB(168, 94, 105, 238),
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return const QuoteCard();
                      },
                      itemCount: 3,
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
              child: FutureBuilder(
                future: futureBookList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final bookList = snapshot.data as List<Book>;
                    return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bookList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BookCard(
                            book: bookList[index],
                          );
                        });
                  } 
                  else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } 
                  else {
                    return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return const BookLoadingCard();
                        });
                  }
                },
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: getPageActions(currentPageIndex),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            )),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          titles[currentPageIndex],
          style: const TextStyle(color: Colors.white),
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
      body: pages[currentPageIndex].call(),
    );
  }
}
