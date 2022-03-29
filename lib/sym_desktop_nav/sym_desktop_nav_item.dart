import 'dart:math' as math;

import 'package:flutter/material.dart';

class SymDesktopNavItem extends StatelessWidget {
  final String itemName;
  final Widget? itemImage;
  final Classify classify;
  final bool withSeparator;
  const SymDesktopNavItem({
    Key? key,
    required this.itemName,
    this.itemImage,
    this.classify = Classify.top,
    this.withSeparator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: itemName,
      waitDuration: const Duration(seconds: 1),
      child: Ink(
        height: 32,
        width: 32,
        child: _getView(),
      ),
    );
  }

  Widget _getView() {
    Widget w = Ink(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
      ),
      child: Center(
        child: Text(
          itemName.substring(0, 1).toUpperCase(),
        ),
      ),
    );
    if (itemImage != null) {
      w = itemImage!;
    }
    return w;
  }
}

enum Classify { top, bottom }
