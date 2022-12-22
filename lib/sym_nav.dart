library sym_desktop_nav;

import 'dart:math' as math;

import 'package:flutter/material.dart';

// Navigation Item
abstract class SymNavItem extends StatelessWidget {
  final String itemName;
  final Widget? itemImage;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  const SymNavItem({
    Key? key,
    required this.itemName,
    this.itemImage,
    this.width,
    this.height,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    Widget child = Center(
      child: Text(
        itemName.substring(0, 1).toUpperCase(),
        style: textStyle,
      ),
    );
    BoxDecoration? decoration;
    if (itemImage != null) {
      child = itemImage!;
      decoration = null;
    } else {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
      );
    }
    return Ink(
      height: height ?? 25,
      width: width ?? 25,
      decoration: decoration,
      child: child,
    );
  }
}

// Navigation Item Wrapperr for desktop layout only
class SymDesktopNavTopItem extends SymNavItem {
  final bool withSeparator;
  const SymDesktopNavTopItem({
    Key? key,
    required final String itemName,
    final Widget? itemImage,
    final double? width,
    final double? height,
    this.withSeparator = false,
  }) : super(key: key, itemName: itemName, itemImage: itemImage);
}

// Navigation Item Wrapperr for desktop layout only
class SymDesktopNavBottomItem extends SymNavItem {
  const SymDesktopNavBottomItem({
    Key? key,
    required final String itemName,
    final double? width,
    final double? height,
    Widget? itemImage,
  }) : super(key: key, itemName: itemName, itemImage: itemImage);
}

// Navigation Item Wrapperr for mobile layout only
class SymMobileNavItem extends SymNavItem {
  final bool withSeparator;
  const SymMobileNavItem({
    Key? key,
    required final String itemName,
    final Widget? itemImage,
    final double? width,
    final double? height,
    this.withSeparator = false,
  }) : super(key: key, itemName: itemName, itemImage: itemImage);
}

// Navigation Selection for desktop layout only
class SymDesktopNavSelection extends StatefulWidget {
  final double height, width, offsetY;
  final Color color;
  final Duration duration;
  final Curve curve;
  const SymDesktopNavSelection({
    Key? key,
    required this.height,
    required this.width,
    required this.offsetY,
    required this.color,
    required this.duration,
    required this.curve,
  }) : super(key: key);

  @override
  _SymDesktopNavSelectionState createState() => _SymDesktopNavSelectionState();
}

class _SymDesktopNavSelectionState extends State<SymDesktopNavSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetYAnimation;
  late CurvedAnimation _curvedAnimation;
  late double _oldOffsetY;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _offsetYAnimation = _createAnimation(0, widget.offsetY);

    _oldOffsetY = widget.offsetY;
    _controller.addListener(() => setState(() {}));
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(SymDesktopNavSelection oldWidget) {
    if (_oldOffsetY == widget.offsetY) return;

    _offsetYAnimation = _createAnimation(_oldOffsetY, widget.offsetY);
    _oldOffsetY = widget.offsetY;
    _controller.reset();
    _controller.forward();

    super.didUpdateWidget(oldWidget);
  }

  Animation<double> _createAnimation(double begin, double end) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(8, _offsetYAnimation.value),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Navigation Selection for mobile layout only
class SymMobileNavSelection extends StatefulWidget {
  final double height, width, offsetX;
  final Color color;
  final Duration duration;
  final Curve curve;
  const SymMobileNavSelection({
    Key? key,
    required this.height,
    required this.width,
    required this.offsetX,
    required this.color,
    required this.duration,
    required this.curve,
  }) : super(key: key);

  @override
  _SymMobileNavSelectionState createState() => _SymMobileNavSelectionState();
}

class _SymMobileNavSelectionState extends State<SymMobileNavSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetXAnimation;
  late CurvedAnimation _curvedAnimation;
  late double _oldOffsetX;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _offsetXAnimation = _createAnimation(0, widget.offsetX);

    _oldOffsetX = widget.offsetX;
    _controller.addListener(() => setState(() {}));
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(SymMobileNavSelection oldWidget) {
    if (_oldOffsetX == widget.offsetX) return;

    _offsetXAnimation = _createAnimation(_oldOffsetX, widget.offsetX);
    _oldOffsetX = widget.offsetX;
    _controller.reset();
    _controller.forward();

    super.didUpdateWidget(oldWidget);
  }

  Animation<double> _createAnimation(double begin, double end) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_offsetXAnimation.value, 6),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Navigation desktop. Only for desktop layout
class SymDesktopNav extends StatefulWidget {
  final List<SymNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;
  final Color? itemSelectedBackgroundColor;
  final Color? lineColor;
  final TextStyle? textStyle;
  final Curve curve;
  final Duration duration;
  final double? width;
  final double? itemWidth;
  final double? itemHeight;
  final double? itemSelectionRadius;
  final double separatorWeight;

  const SymDesktopNav({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.backgroundColor,
    this.textStyle,
    this.itemSelectedBackgroundColor,
    this.lineColor,
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.duration = const Duration(milliseconds: 500),
    this.width,
    this.itemWidth,
    this.itemHeight,
    this.itemSelectionRadius,
    this.separatorWeight = 1.5,
  })  : assert(separatorWeight < 8),
        super(key: key);

  @override
  _SymDesktopNavState createState() => _SymDesktopNavState();
}

class _SymDesktopNavState extends State<SymDesktopNav> {
  @override
  Widget build(BuildContext context) {
    List<List<SymNavItem>> categorizedItems = [];
    categorizedItems
        .add(List.of(widget.items.whereType<SymDesktopNavTopItem>()));
    categorizedItems
        .add(List.of(widget.items.whereType<SymDesktopNavBottomItem>()));

    return Material(
      color: widget.backgroundColor ?? const Color(0xFFF5F5F5),
      textStyle: widget.textStyle,
      child: Container(
        width: widget.width ?? 56,
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
            SymDesktopNavSelection(
              height: widget.itemHeight ?? 40,
              width: widget.itemHeight ?? 40,
              offsetY: _getYOffset(),
              color:
                  widget.itemSelectedBackgroundColor ?? const Color(0xFF212121),
              duration: widget.duration,
              curve: widget.curve,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _item(
      int groupIndex, int valueIndex, int groupValuesLength, SymNavItem value) {
    return Column(
      children: [
        Ink(
          height: widget.width ?? 56,
          width: widget.width ?? 56,
          child: Center(
            child: Ink(
              height: widget.itemHeight ?? 40,
              width: widget.itemHeight ?? 40,
              child: InkWell(
                onTap: () {
                  widget.onItemSelected.call(widget.items.indexOf(value));
                },
                borderRadius:
                    BorderRadius.circular(widget.itemSelectionRadius ?? 8),
                hoverColor:
                    widget.itemSelectedBackgroundColor?.withOpacity(0.5) ??
                        const Color(0xFF000000).withOpacity(0.1),
                child: Ink(
                  child: value,
                ),
              ),
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
          height: widget.separatorWeight,
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
        extra = 8.0 * (separatorIndexes.indexOf(separatorIndexes[i]) + 1);
      } else {
        // if (widget.selectedIndex != 0) {
        //   extra = 8.0;
        // }
      }
    }

    double offsetY = ((16.0 + 40) * widget.selectedIndex) + 8.0 + extra;
    if (widget.items[widget.selectedIndex] is SymDesktopNavBottomItem) {
      offsetY = ((MediaQuery.of(context).size.height) -
              (40 + 16.0) * (widget.items.length - widget.selectedIndex)) +
          8.0;
    }

    return offsetY;
  }
}

class SymMobileNav extends StatefulWidget {
  final List<SymNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;
  final Color? itemSelectedBackgroundColor;
  final Color? lineColor;
  final TextStyle? textStyle;
  final Curve curve;
  final Duration duration;
  final double? height;
  final double? itemWidth;
  final double? itemHeight;
  final double? itemSelectionRadius;
  final double separatorWeight;
  const SymMobileNav({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.backgroundColor,
    this.textStyle,
    this.itemSelectedBackgroundColor,
    this.lineColor,
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.duration = const Duration(milliseconds: 500),
    this.height,
    this.itemWidth,
    this.itemHeight,
    this.itemSelectionRadius,
    this.separatorWeight = 1,
  })  : assert(separatorWeight < 8),
        super(key: key);

  @override
  State<SymMobileNav> createState() => _SymMobileNavState();
}

class _SymMobileNavState extends State<SymMobileNav> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor ?? const Color(0xFFF5F5F5),
      textStyle: widget.textStyle,
      child: Container(
          height: widget.height ?? 48,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: widget.lineColor ?? const Color(0xFFE0E0E0),
                style: BorderStyle.solid,
                width: 0.5,
              ),
            ),
          ),
          child: Stack(
            children: [
              SymMobileNavSelection(
                height: widget.itemHeight ?? 36,
                width: widget.itemHeight ?? 36,
                offsetX: _getXOffset(),
                color: widget.itemSelectedBackgroundColor ??
                    const Color(0xFF212121),
                duration: widget.duration,
                curve: widget.curve,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.items
                    .asMap()
                    .map(
                      (itemIndex, itemValue) => MapEntry(
                        itemIndex,
                        Expanded(
                          child: _item(
                            itemIndex,
                            itemValue,
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ],
          )),
    );
  }

  Widget _item(int valueIndex, SymNavItem value) {
    return Row(
      children: [
        Expanded(
          child: Ink(
            height: widget.height ?? 48,
            width: widget.height ?? 48,
            child: Center(
              child: Ink(
                height: widget.itemHeight ?? 36,
                width: widget.itemHeight ?? 36,
                child: InkWell(
                  onTap: () {
                    widget.onItemSelected.call(widget.items.indexOf(value));
                  },
                  borderRadius:
                      BorderRadius.circular(widget.itemSelectionRadius ?? 8),
                  hoverColor:
                      widget.itemSelectedBackgroundColor?.withOpacity(0.5) ??
                          const Color(0xFF000000).withOpacity(0.1),
                  child: Ink(
                    child: value,
                  ),
                ),
              ),
            ),
          ),
        ),
        value is SymMobileNavItem && value.withSeparator ? _separator() : Ink()
      ],
    );
  }

  Widget _separator() {
    return Ink(
      width: 8,
      child: Center(
        child: Ink(
          width: widget.separatorWeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: widget.lineColor ?? const Color(0xFFE0E0E0),
          ),
          height: 25,
        ),
      ),
    );
  }

  double _getXOffset() {
    double extra = 0;

    if ((widget.items[widget.selectedIndex] as SymMobileNavItem)
        .withSeparator) {
      extra = 0.0;
    } else {
      extra = 4.0;
    }

    double offsetX = ((MediaQuery.of(context).size.width /
                widget.items.length) *
            widget.selectedIndex) +
        (((MediaQuery.of(context).size.width / widget.items.length) / 2) - 22) +
        extra;

    return offsetX;
  }
}
