import 'package:flutter/material.dart';
import 'package:sym_nav/sym_nav.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Text('Section area index: $_index'),
      ),
      bottomNavigationBar: SymMobileNav(
        items: [
          const SymMobileNavItem(
            itemName: 'Profile',
          ),
          SymMobileNavItem(
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
          SymMobileNavItem(
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
          const SymMobileNavItem(
            itemName: 'Discuss',
            withSeparator: true,
          ),
          const SymMobileNavItem(
            itemName: 'Test',
          ),
        ],
        onItemSelected: (index) {
          _index = index;
          setState(() {});
        },
        selectedIndex: _index,
        itemSelectedBackgroundColor: const Color(0xFF000000),
      ),
    );
  }
}
