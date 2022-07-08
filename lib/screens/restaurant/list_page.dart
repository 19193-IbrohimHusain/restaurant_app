import 'package:flutter/material.dart';
import 'package:restaurant_app1/data/model/model_restaurant.dart';
import 'package:restaurant_app1/screens/restaurant/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app1/utils/resource/style.dart';
import 'detail_page.dart';

class ListRestaurant extends StatelessWidget {
  static const routeName = 'list_page';
  static const String listTile = 'list_page';
  final Icon customIcon = const Icon(Icons.search);
  final Widget appBarTitle = Text('Restaurant',
      style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold));
  final String filter = '';

  ListRestaurant({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 6.0,
            ),
            child: Text(
              'Recommended restaurant for you!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Flexible(
            child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // error widget
                    return Text("404 Not Found",
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.bold));
                  }
                  final List<DetailRestaurant> restaurant =
                      restaurantFromJson(snapshot.data.toString()).restaurants;
                  return ListView.builder(
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return _buildRestaurant(restaurant[index], context);
                      });
                }),
          ),
        ],
      ),
    );
  }
}

Widget _buildRestaurant(DetailRestaurant restaurant, BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantsPage.routeName,
          arguments: restaurant,
        );
      },
      child: Container(
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
      ));
}
