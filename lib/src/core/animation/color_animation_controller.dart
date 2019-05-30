import 'package:flutter/widgets.dart';

abstract class ColorAnimatableController {
  Animation<Color> get animation;

  TickerFuture forward({double from});

  TickerFuture reverse({double from});

  void addListener(Function() callback);

  void dispose();

  factory ColorAnimatableController(
          {@required Color begin,
          @required Color end,
          @required Duration duration,
          @required TickerProvider vsync,
          Curve curve = Curves.easeOut}) =>
      ColorAnimatableController.byController(
          begin: begin,
          end: end,
          controller: AnimationController(
            duration: duration,
            vsync: vsync,
          ));

  factory ColorAnimatableController.byController(
          {@required Color begin,
          @required Color end,
          @required AnimationController controller,
          Curve curve = Curves.easeOut}) =>
      _ColorAnimationControllerWrapper(
        begin: begin,
        end: end,
        curve: curve,
        animationController: controller,
      );
}

class _ColorAnimationControllerWrapper implements ColorAnimatableController {
  // -----
  // Internal
  // -----
  final Color begin;
  final Color end;
  final Curve curve;
  final AnimationController animationController;

  Animation<Color> _animation;

  _ColorAnimationControllerWrapper({
    @required this.begin,
    @required this.end,
    @required this.curve,
    @required this.animationController,
  }) : _animation = CurvedAnimation(parent: animationController, curve: curve)
            .drive(ColorTween(begin: begin, end: end));

  // -----
  // ColorAnimationController
  // -----

  @override
  Animation<Color> get animation => _animation;

  @override
  TickerFuture forward({double from}) =>
      animationController.forward(from: from);

  @override
  TickerFuture reverse({double from}) =>
      animationController.reverse(from: from);

  @override
  void addListener(Function() callback) =>
      animationController.addListener(callback);

  @override
  void dispose() => animationController.dispose();
}
