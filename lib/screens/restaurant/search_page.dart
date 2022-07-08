import 'package:flutter/material.dart';
import 'package:restaurant_app1/data/model/model_restaurant.dart';
import 'package:restaurant_app1/utils/resource/style.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Icon customIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text('Search');

  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBarTitle,
          elevation: 0,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              icon: customIcon,
              onPressed: () {
                setState(() {
                  searchController.text = '';
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    appBarTitle = ListTile(
                      leading: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      title: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Enter restaurant name',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    customIcon = const Icon(
                      Icons.search,
                      color: Colors.white,
                    );
                    appBarTitle = const Text('Search');
                  }
                });
              },
            ),
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 6.0,
            ),
            child: Text(
              'One step away to find a restaurant!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/local_restaurant.json'),
                  builder: (context, snapshot) {
                    final List<DetailRestaurant> restaurants =
                        parseRestaurant(snapshot.data);
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        return restaurants
                                .where((restaurant) => restaurant.name
                                    .toString()
                                    .toLowerCase()
                                    .contains(filter.toLowerCase()))
                                .isEmpty
                            ? const Center(
                                child: Text('404 Not Found'),
                              )
                            : ListView.builder(
                                itemCount: restaurants.length,
                                itemBuilder: (context, index) {
                                  if (filter == '') {
                                    return RestaurantCard(restaurants[index]);
                                  } else if (restaurants[index]
                                      .name
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())) {
                                    return RestaurantCard(restaurants[index]);
                                  } else {
                                    return Container();
                                  }
                                });
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  })),
        ]));
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(this.restaurant, {Key? key}) : super(key: key);
  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 1),
              blurRadius: 10,
            ),
          ]),
      child: Stack(
        children: [
          Row(
            children: [
              Flexible(
                child: Image.network(restaurant.pictureId, width: 100),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                            Text(restaurant.city),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Text(restaurant.rating.toString())
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
