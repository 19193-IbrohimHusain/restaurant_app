import 'package:flutter/material.dart';
import 'package:restaurant_app1/data/model/model_restaurant.dart';
import 'package:restaurant_app1/screens/home/home_page.dart';
import 'package:restaurant_app1/screens/restaurant/list_page.dart';
import 'package:restaurant_app1/screens/restaurant/detail_page.dart';
import 'package:restaurant_app1/screens/restaurant/search_page.dart';
import 'package:restaurant_app1/utils/navigation.dart';
import 'package:restaurant_app1/screens/splash/splash_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      navigatorKey: navigatorKey,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        ListRestaurant.routeName: (context) => ListRestaurant(),
        RestaurantsPage.routeName: (context) => RestaurantsPage(
              restaurant: ModalRoute.of(context)?.settings.arguments
                  as DetailRestaurant,
            ),
      },
    );
  }
}
