import 'package:flutter/material.dart';
import 'package:sym_nav/sym_nav.dart';

class Desktop extends StatefulWidget {
  const Desktop({Key? key}) : super(key: key);

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SymDesktopNav(
              textStyle: const TextStyle(
                color: Color(0xFF9E9E9E),
              ),
              selectedIndex: _index,
              itemSelectedBackgroundColor: const Color(0xFF000000),
              items: [
                const SymDesktopNavTopItem(
                  itemName: 'Profile',
                ),
                SymDesktopNavTopItem(
                  itemName: 'Home',
                  withSeparator: true,
                  itemImage: _index == 1
                      ? const Icon(
                          Icons.alarm_add,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        )
                      : const Icon(
                          Icons.access_alarm,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        ),
                ),
                SymDesktopNavTopItem(
                  itemName: 'Mingle',
                  itemImage: _index == 2
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        )
                      : const Icon(
                          Icons.photo,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        ),
                ),
                const SymDesktopNavTopItem(
                  itemName: 'Discuss',
                  withSeparator: true,
                ),
                const SymDesktopNavTopItem(
                  itemName: 'Test',
                ),
                SymDesktopNavBottomItem(
                  itemName: 'Notifikasi',
                  itemImage: _index == 5
                      ? const Icon(
                          Icons.notification_add,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        )
                      : const Icon(
                          Icons.notifications,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        ),
                ),
                SymDesktopNavBottomItem(
                  itemName: 'Notifikasi',
                  itemImage: _index == 6
                      ? const Icon(
                          Icons.notification_add,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        )
                      : const Icon(
                          Icons.notifications,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        ),
                ),
                SymDesktopNavBottomItem(
                  itemName: 'Settings',
                  itemImage: _index == 7
                      ? const Icon(
                          Icons.settings_accessibility,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        )
                      : const Icon(
                          Icons.settings,
                          size: 25,
                          color: Color(0xFF9E9E9E),
                        ),
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
      ),
    );
  }
}
