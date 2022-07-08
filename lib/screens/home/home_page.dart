import 'package:flutter/material.dart';
import 'package:restaurant_app1/screens/navbar/fav_restaurant.dart';
import 'package:restaurant_app1/screens/restaurant/list_page.dart';
import 'package:restaurant_app1/screens/navbar/notification_page.dart';
import 'package:restaurant_app1/screens/navbar/profile_page.dart';
import 'package:restaurant_app1/utils/resource/style.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

int indexBottomNav = 0;
List<Widget> widgetOptions = [
  ListRestaurant(),
  const FavoritePage(),
  const NotificationPage(),
  const ProfilePage()
];

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(indexBottomNav),
      bottomNavigationBar: SalomonBottomBar(
          onTap: (index) {
            setState(() {
              indexBottomNav = index;
            });
          },
          currentIndex: indexBottomNav,
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                selectedColor: primaryColor),
            SalomonBottomBarItem(
              selectedColor: primaryColor,
              icon: const Icon(Icons.favorite_outline_rounded),
              title: const Text("Favorite"),
            ),
            SalomonBottomBarItem(
                selectedColor: primaryColor,
                icon: const Icon(Icons.notifications_none_rounded),
                title: const Text("Notification")),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                title: const Text("Profile"),
                selectedColor: primaryColor),
          ]),
    );
  }
}
