import 'package:flutter/widgets.dart';
import 'package:tio_core/src/dimensions/dimensions_data.dart';

/// Applies dimensions to descendant widgets.
///
/// Dimensions describes the sizes and units of an application.
///
/// Descendant widgets obtain the current Dimensions [DimensionsData] object
/// using [Dimensions.of]. When a widget uses [Dimensions.of], it is
/// automatically rebuilt if the dimensions later change, so that the changes
/// can be applied. TODO: Is this true in this case, because we are iterating the tree manually?
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
    _InheritedDimensions<D> inheritedDimensions;
    TypeMatcher<_InheritedDimensions<D>> typeMatcher = TypeMatcher();
    context.visitAncestorElements((element) {
      if (typeMatcher.check(element.widget)) {
        inheritedDimensions = element.widget as _InheritedDimensions<D>;
        return false;
      }
      return true;
    });
    if (inheritedDimensions == null) throw DimensionsNotFound(D);
    return inheritedDimensions.dimensions.data;
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedDimensions<D>(dimensions: this, child: child);
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
  String toString() => "Dimensions of type $_type could not be found in the "
      "ancestor tree.";
}
