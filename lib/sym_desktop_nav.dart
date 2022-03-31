library sym_desktop_nav;

import 'package:flutter/material.dart';
import 'package:sym_nav/sym_desktop_nav/sym_desktop_nav_item.dart';
import 'package:sym_nav/sym_desktop_nav/sym_desktop_nav_selection.dart';

class SymDesktopNav extends StatefulWidget {
  final List<SymDesktopNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;
  final Color? itemSelectedBackgroundColor;
  final Color? lineColor;
  final TextStyle? textStyle;
  final Curve curve;
  final Duration duration;

  const SymDesktopNav(
      {Key? key,
      required this.items,
      required this.selectedIndex,
      required this.onItemSelected,
      this.backgroundColor,
      this.textStyle,
      this.itemSelectedBackgroundColor,
      this.lineColor,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _SymDesktopNavState createState() => _SymDesktopNavState();
}

class _SymDesktopNavState extends State<SymDesktopNav> {
  @override
  Widget build(BuildContext context) {
    List<List<SymDesktopNavItem>> categorizedItems = [];
    categorizedItems
        .add(List.of(widget.items.whereType<SymDesktopNavTopItem>()));
    categorizedItems
        .add(List.of(widget.items.whereType<SymDesktopNavBottomItem>()));

    return Material(
      color: widget.backgroundColor ?? const Color(0xFFF5F5F5),
      textStyle: widget.textStyle,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: widget.lineColor ?? const Color(0xFFE0E0E0),
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
              ),
              child: SymDesktopNavSelection(
                height: 44,
                width: 44,
                offsetY: _getYOffset(),
                color: widget.itemSelectedBackgroundColor ??
                    const Color(0xFF212121),
                duration: widget.duration,
                curve: widget.curve,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categorizedItems
                  .asMap()
                  .map(
                    (groupIndex, groupValue) => MapEntry(
                      groupIndex,
                      Column(
                        children: groupValue
                            .asMap()
                            .map(
                              (itemIndex, itemValue) => MapEntry(
                                itemIndex,
                                _item(
                                  groupIndex,
                                  itemIndex,
                                  groupValue.length,
                                  itemValue,
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(int groupIndex, int valueIndex, int groupValuesLength,
      SymDesktopNavItem value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: (value is SymDesktopNavTopItem && valueIndex == 0) ? 16 : 8,
            bottom: (value is SymDesktopNavBottomItem &&
                    valueIndex == groupValuesLength - 1)
                ? 16
                : 8,
            left: 8,
            right: 8,
          ),
          child: InkWell(
            onTap: () {
              widget.onItemSelected.call(widget.items.indexOf(value));
            },
            borderRadius: BorderRadius.circular(8),
            hoverColor: widget.itemSelectedBackgroundColor?.withOpacity(0.5) ??
                const Color(0xFF000000).withOpacity(0.1),
            child: Ink(
              padding: const EdgeInsets.all(6),
              child: value,
            ),
          ),
        ),
        value is SymDesktopNavTopItem && value.withSeparator
            ? _separator()
            : Ink()
      ],
    );
  }

  Widget _separator() {
    return Ink(
      height: 8,
      child: Center(
        child: Ink(
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: widget.lineColor ?? const Color(0xFFE0E0E0),
          ),
          height: 1.5,
        ),
      ),
    );
  }

  double _getYOffset() {
    double extra = 0;
    List<int> separatorIndexes = [];
    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i] is SymDesktopNavTopItem &&
          (widget.items[i] as SymDesktopNavTopItem).withSeparator) {
        separatorIndexes.add(i);
      }
    }

    for (var i = 0; i < separatorIndexes.length; i++) {
      if (widget.selectedIndex - separatorIndexes[i] >= 1) {
        extra = 8.0 * separatorIndexes[i];
      } else {
        if (widget.selectedIndex != 0) {
          extra = 8.0;
        }
      }
    }

    double offsetY = (16.0 + 44) * widget.selectedIndex + extra;
    if (widget.items[widget.selectedIndex] is SymDesktopNavBottomItem) {
      offsetY = ((MediaQuery.of(context).size.height - 16.0) -
          (44 + 16.0) * (widget.items.length - widget.selectedIndex));
    }
    return offsetY;
  }
}
