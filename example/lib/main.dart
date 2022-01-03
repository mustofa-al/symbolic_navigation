import 'package:flutter/material.dart';
import 'package:sym_desktop_nav/sym_desktop_nav.dart';
import 'package:sym_desktop_nav/sym_desktop_nav/sym_desktop_nav_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Row(
          children: [
            SymDesktopNav(
              textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
              initialIndex: 0,
              items: const [
                SymDesktopNavItem(
                    itemName: 'Home',
                    itemImage: Icon(
                      Icons.access_alarm,
                      size: 20,
                      color: Color(0xFFFFFFFF),
                    )),
                SymDesktopNavItem(
                  itemName: 'Mingle',
                  itemImage: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SymDesktopNavItem(
                  itemName: 'Discuss',
                ),
                SymDesktopNavItem(
                  itemName: 'Notifikasi',
                  itemImage: Icon(
                    Icons.notifications,
                    size: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                  classify: Classify.bottom,
                ),
                SymDesktopNavItem(
                  itemName: 'Settings',
                  itemImage: Icon(
                    Icons.settings,
                    size: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                  classify: Classify.bottom,
                ),
              ],
              onItemSelected: (index) {
                print('object $index');
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Text('Section area'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
