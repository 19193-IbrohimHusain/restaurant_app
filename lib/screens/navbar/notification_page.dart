import 'package:flutter/material.dart';
import 'package:restaurant_app1/utils/resource/style.dart';

class NotificationPage extends StatelessWidget {
  static const routeName = 'notification_page';
  static const String notification = 'notification_page';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.notifications_outlined),
            SizedBox(width: 10),
            Text("Notification"),
          ],
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        height: 900,
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Text("You don't have any notifications",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
