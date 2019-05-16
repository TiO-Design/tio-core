import 'package:flutter/widgets.dart';
import 'package:tio_core/src/util/on_next_frame.dart';
import 'package:tio_core/tio_core.dart';

mixin TioThemeAware<W extends StatefulWidget, T extends TioThemeData>
    on State<W> {
  T tioTheme;

  @override
  void initState() {
    super.initState();
    onNextFrame(() => tioTheme = TioTheme.of<T>(context));
  }

  @override
  void didChangeDependencies() {
    tioTheme = TioTheme.of<T>(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(oldWidget) {
    tioTheme = TioTheme.of<T>(context);
    super.didUpdateWidget(oldWidget);
  }
}
