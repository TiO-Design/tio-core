import 'package:flutter/cupertino.dart';

class OpacityTransition extends AnimatedWidget {
  final Animation<double> opacity;
  final Widget child;

  OpacityTransition({
    Key key,
    @required this.child,
    @required this.opacity,
  }) : super(key: key, listenable: opacity);

  @override
  Widget build(BuildContext context) =>
      Opacity(child: child, opacity: opacity.value);
}
