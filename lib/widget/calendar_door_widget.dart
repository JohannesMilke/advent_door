import 'dart:math';

import 'package:flutter/material.dart';

class CalendarDoorWidget extends StatefulWidget {
  final Widget child;
  final Widget outerDoor;
  final Widget innerDoor;
  final bool opened;

  const CalendarDoorWidget({
    @required this.outerDoor,
    @required this.innerDoor,
    @required this.child,
    this.opened = false,
    Key key,
  }) : super(key: key);

  @override
  CalendarDoorWidgetState createState() => CalendarDoorWidgetState();
}

class CalendarDoorWidgetState extends State<CalendarDoorWidget>
    with TickerProviderStateMixin {
  static final flipCurve = Cubic(0.455, 0.030, 0.515, 0.955);

  AnimationController _controller;
  Animation<double> animation;

  bool opened;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: flipCurve));

    opened = widget.opened;
    if (opened) {
      _controller.value = 1.0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openDoorUntil = 3 / 5;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          final Widget door = _controller.value <= 0.5 / openDoorUntil
              ? widget.outerDoor
              : widget.innerDoor;

          return Stack(fit: StackFit.expand, children: <Widget>[
            widget.child,
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_controller.value * -pi * openDoorUntil),
              child: door,
            ),
          ]);
        },
      ),
    );
  }

  void onTap() {
    if (opened) return;

    opened = true;
    _controller.forward();
  }
}
