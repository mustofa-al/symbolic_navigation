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
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SymDesktopNav(
            textStyle: const TextStyle(
              color: Color(0xFF9E9E9E),
            ),
            initialIndex: _index,
            items: [
              SymDesktopNavItem(
                itemName: 'Home',
                itemImage: _index == 0
                    ? const Icon(
                        Icons.alarm_add,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      )
                    : const Icon(
                        Icons.access_alarm,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      ),
              ),
              SymDesktopNavItem(
                itemName: 'Mingle',
                itemImage: _index == 1
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      )
                    : const Icon(
                        Icons.photo,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      ),
                withSeparator: true,
              ),
              const SymDesktopNavItem(
                itemName: 'Discuss',
              ),
              SymDesktopNavItem(
                itemName: 'Notifikasi',
                itemImage: _index == 3
                    ? const Icon(
                        Icons.notification_add,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      )
                    : const Icon(
                        Icons.notifications,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      ),
                classify: Classify.bottom,
              ),
              SymDesktopNavItem(
                itemName: 'Settings',
                itemImage: _index == 4
                    ? const Icon(
                        Icons.settings_accessibility,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      )
                    : const Icon(
                        Icons.settings,
                        size: 20,
                        color: Color(0xFF9E9E9E),
                      ),
                classify: Classify.bottom,
              ),
            ],
            onItemSelected: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: Text('Section area index: $_index'),
            ),
          )
        ],
      ),
    );
  }
}
