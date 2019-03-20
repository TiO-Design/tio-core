import 'package:flutter/widgets.dart';
import 'package:tio_core/src/dimensions/dimensions_data.dart';

/// Applies dimensions to descendant widgets.
///
/// Dimensions describes the sizes and units of an application.
///
/// Descendant widgets obtain the current Dimensions [DimensionsData] object
/// using [Dimensions.of]. When a widget uses [Dimensions.of], it is
/// automatically rebuilt if the dimensions later change, so that the changes
/// can be applied.
///
/// Take a look at [DimensionsData] to learn more about how to extend
/// [DimensionsData] to add your own values.
@immutable
class Dimensions<D extends DimensionsData> extends StatelessWidget {
  /// Applies the given [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  Dimensions({Key key, @required this.data, @required this.child})
      : assert(child != null),
        assert(data != null),
        super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Specifies the dimension values for descendant widgets.
  final D data;

  static D of<D extends DimensionsData>(BuildContext context) {
    _InheritedDimensions<D> inheritedDimensions = context
        .inheritFromWidgetOfExactType(_typeOf<_InheritedDimensions<D>>());

    if (inheritedDimensions != null) {
      return inheritedDimensions.dimensions.data;
    }

    throw DimensionsNotFound(D);
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedDimensions<D>(dimensions: this, child: child);

  // -----
  // Util
  // -----

  static Type _typeOf<T>() => T;
}

class _InheritedDimensions<D extends DimensionsData> extends InheritedWidget {
  _InheritedDimensions(
      {Key key, @required this.dimensions, @required Widget child})
      : assert(dimensions != null),
        super(key: key, child: child);

  final Dimensions<D> dimensions;

  @override
  bool updateShouldNotify(_InheritedDimensions old) =>
      dimensions.data != old.dimensions.data;
}

class DimensionsNotFound extends Error {
  final Type _type;

  DimensionsNotFound(this._type);

  @override
  String toString() => "Dimensions of type $_type is not an ancestor.";
}
