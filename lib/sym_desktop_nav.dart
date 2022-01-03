library sym_desktop_nav;

import 'package:flutter/material.dart';
import 'package:sym_desktop_nav/sym_desktop_nav/sym_desktop_nav_item.dart';

class SymDesktopNav extends StatefulWidget {
  final List<SymDesktopNavItem> items;
  final int initialIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;
  final Color? itemBackgroundColor;
  final TextStyle? textStyle;

  const SymDesktopNav({
    Key? key,
    required this.items,
    required this.initialIndex,
    required this.onItemSelected,
    this.backgroundColor,
    this.textStyle,
    this.itemBackgroundColor,
  }) : super(key: key);

  @override
  _SymDesktopNavState createState() => _SymDesktopNavState();
}

class _SymDesktopNavState extends State<SymDesktopNav> {
  @override
  Widget build(BuildContext context) {
    List<List<SymDesktopNavItem>> categorizedItems = [];
    categorizedItems.add(List.of(
        widget.items.where((element) => element.classify == Classify.top)));
    categorizedItems.add(List.of(
        widget.items.where((element) => element.classify == Classify.bottom)));

    return Material(
      color: widget.backgroundColor ?? const Color(0xFF5e4229),
      textStyle: widget.textStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categorizedItems
            .asMap()
            .map((key, value) => MapEntry(
                key,
                Column(
                  children: value
                      .asMap()
                      .map(
                          (key1, value1) => MapEntry(key1, _item(key1, value1)))
                      .values
                      .toList(),
                )))
            .values
            .toList(),
      ),
    );
  }

  Widget _item(int key, SymDesktopNavItem value) {
    return Padding(
      padding: EdgeInsets.only(
        top: key == 0 ? 16 : 8,
        bottom: key == widget.items.length ? 16 : 8,
        left: 8,
        right: 8,
      ),
      child: InkWell(
        onTap: () {
          widget.onItemSelected.call(widget.items.indexOf(value));
        },
        borderRadius: BorderRadius.circular(8),
        hoverColor: widget.itemBackgroundColor?.withOpacity(0.5) ??
            const Color(0xFFFFFFFF).withOpacity(0.1),
        child: Ink(
          padding: const EdgeInsets.all(6),
          decoration: value == widget.items[widget.initialIndex]
              ? BoxDecoration(
                  color: const Color(0xFFB26941).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: value,
        ),
      ),
    );
  }
}
