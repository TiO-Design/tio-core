import 'package:flutter/widgets.dart';

abstract class ColorAnimationController {
  Animation<Color> get animation;

  TickerFuture forward({double from});

  TickerFuture reverse({double from});

  void addListener(Function() callback);

  void dispose();

  factory ColorAnimationController(
          {@required Color begin,
          @required Color end,
          @required Duration duration,
          @required TickerProvider vsync,
          Curve curve = Curves.easeOut}) =>
      _ColorAnimationControllerImpl(
          begin: begin,
          end: end,
          duration: duration,
          curve: curve,
          vsync: vsync);
}

class _ColorAnimationControllerImpl implements ColorAnimationController {
  // -----
  // Internal
  // -----
  final Color begin;
  final Color end;
  final Duration duration;
  final Curve curve;

  Animation<Color> _animation;
  final AnimationController _animationController;

  _ColorAnimationControllerImpl({
    @required this.begin,
    @required this.end,
    @required this.duration,
    @required this.curve,
    @required TickerProvider vsync,
  }) : _animationController =
            AnimationController(vsync: vsync, duration: duration) {
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: curve,
    ).drive(ColorTween(begin: begin, end: end));
  }

  // -----
  // ColorAnimationController
  // -----

  @override
  Animation<Color> get animation => _animation;

  @override
  TickerFuture forward({double from}) =>
      _animationController.forward(from: from);

  @override
  TickerFuture reverse({double from}) =>
      _animationController.reverse(from: from);

  @override
  void addListener(Function() callback) =>
      _animationController.addListener(callback);

  @override
  void dispose() => _animationController.dispose();
}
