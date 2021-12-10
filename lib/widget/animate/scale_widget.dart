import 'package:flutter/material.dart';

class ScaleWidget extends StatefulWidget {

  final Widget child;

  ScaleWidget({
    Key? key,
    required this.child
  }): super(key: key);

  @override
  _ScaleWidgetState createState() => _ScaleWidgetState();
}

class _ScaleWidgetState extends State<ScaleWidget> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
              alignment: Alignment.center,
              scale: _controller.value,
              child: child
          );
        },
        child: widget.child
    )
    ;
  }

}
