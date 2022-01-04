import 'package:flutter/material.dart';

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
