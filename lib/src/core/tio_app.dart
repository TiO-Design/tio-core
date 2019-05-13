import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/src/dimensions/dimensions.dart';
import 'package:tio_core/src/dimensions/dimensions_data.dart';
import 'package:tio_core/src/theming/theme.dart';

class TioApp<D extends DimensionsData> extends StatelessWidget {
  final Widget home;
  final TioThemeData theme;

  /// The top level [DimensionsData] used for this App.
  /// Those can be used by calling [Dimensions.of] with the specified type [D].
  final D dimensions;

  /// Title of the underlying [WidgetsApp]. Empty string by default.
  final String title;
  final RouteFactory onGenerateRoute;
  final List<LocalizationsDelegate> localizationsDelegates;

  final Color color;

  TioApp({
    @required this.home,
    @required this.theme,
    @required this.dimensions,
    this.title,
    this.onGenerateRoute,
    this.localizationsDelegates,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.asMaterialTheme(),
      child: Dimensions<D>(
        data: dimensions,
        child: WidgetsApp(
          title: title ?? "",
          color: color ?? Colors.white,
          builder: (context, widget) => widget,
          onGenerateRoute: onGenerateRoute,
          pageRouteBuilder: _pageRouteBuilder,
          home: home,
          localizationsDelegates: _localizationsDelegates,
        ),
      ),
    );
  }

  PageRoute<T> _pageRouteBuilder<T>(RouteSettings settings, builder) =>
      MaterialPageRoute(settings: settings, builder: builder);

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (localizationsDelegates != null) yield* localizationsDelegates;
    yield DefaultMaterialLocalizations.delegate;
    yield DefaultCupertinoLocalizations.delegate;
  }
}
