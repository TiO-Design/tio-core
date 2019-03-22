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

  /// The data from the closest [Dimensions] (with the specific type [D]
  /// instance that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// Let AppDimensionsData be a subclass of [DimensionsData].
  /// To obtain AppDimensionsData, use [Dimensions.of] with
  /// AppDimensionsData as the generic type.
  ///
  /// {@tool sample}
  /// ```dart
  /// Dimensions.of<AppDimensionsData>(context).someValue;
  /// ```
  ///
  /// This assumes that you have a [Dimensions] ancestor somewhere in your
  /// ancestor tree with the same generic type, else [DimensionsNotFound]
  /// will be thrown.
  ///
  /// {@tool sample}
  /// ```dart
  /// Dimensions<AppDimensionsData>(
  ///   data: AppDimensionsData(),
  ///   child: ...
  /// )
  /// ```
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

/// Creates new scoped [Dimensions] that use the system text scale factor
/// as [DimensionsData.scale].
class TextScaleAwareDimensions<D extends DimensionsData>
    extends StatelessWidget {
  final D data;
  final Widget child;

  TextScaleAwareDimensions({this.data, @required this.child});

  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;
    var data = this.data ?? Dimensions.of<D>(context);
    return Dimensions<D>(
        data: data.copyWith(scale: data.scale * textScaleFactor), child: child);
  }
}

// -----
// Secondary stuff
// -----

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
