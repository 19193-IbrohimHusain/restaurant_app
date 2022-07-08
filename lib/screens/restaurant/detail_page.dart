import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app1/data/model/model_restaurant.dart';
import 'package:restaurant_app1/screens/home/home_page.dart';
import 'package:restaurant_app1/utils/resource/style.dart';

class RestaurantsPage extends StatelessWidget {
  static const routeName = '/restaurant_page';

  final DetailRestaurant restaurant;

  const RestaurantsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(restaurant.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            child: Image.network(restaurant.pictureId),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const FavoriteButton(),
                      ),
                    ]),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: primaryColor,
                          size: 30,
                        ),
                        Text(
                          restaurant.city,
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Text(restaurant.rating.toString(),
                            style: GoogleFonts.openSans(fontSize: 20))
                      ],
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Divider(color: Colors.grey),
                const Text('Foods Menu'),
                Column(
                  children: restaurant.menu.foods
                      .map((food) => Column(
                            children: [
                              Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.food_bank,
                                      color: primaryColor,
                                      size: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(food.name),
                                          const SizedBox(
                                              height: 10, width: 100),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
                const Divider(color: Colors.grey),
                const Text('Drinks Menu'),
                Column(
                  children: restaurant.menu.drinks
                      .map((drink) => Column(
                            children: [
                              Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.local_drink,
                                      color: secondaryColor,
                                      size: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(drink.name),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
                const Divider(color: Colors.grey),
                Container(
                  margin: const EdgeInsets.only(bottom: 40, top: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Give this restaurant a rating",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Rating((rating) {})
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          color: Colors.red,
          size: 40,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Success!'),
                  content: const Text('Restaurant Added To Favorite'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        });
  }
}

class Rating extends StatefulWidget {
  final int maxRating;
  final Function(int) onRatingSelected;
  // ignore: use_key_in_widget_constructors
  const Rating(this.onRatingSelected, [this.maxRating = 5]);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    final stars = List.generate(widget.maxRating, (index) {
      return GestureDetector(
        child: ratingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Success!'),
                  content: const Text('Restaurant Rated'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        },
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stars,
    );
  }

  Widget ratingStar(int index) {
    if (index < _currentRating) {
      return const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 40,
      );
    } else {
      return const Icon(
        Icons.star_outline,
        size: 30,
      );
    }
  }
}
