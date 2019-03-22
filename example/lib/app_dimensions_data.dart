import 'package:tio_core/tio_core.dart';

class AppDimensionsData extends DimensionsData {
  /// Border radius scaled by 1.
  double get borderRadiusSmall => onGrid(1);

  /// Border radius scaled by 2.
  double get borderRadiusMedium => onGrid(2);

  /// Border radius scaled by 4.
  double get borderRadiusBig => onGrid(4);

  /// Grid unit scaled by 1.
  double get gridUnitTiny => onGrid(1);

  /// Grid unit scaled by 2.
  double get gridUnitSmall => onGrid(2);

  /// Grid unit scaled by 4.
  double get gridUnitMedium => onGrid(4);

  /// Grid unit scaled by 6.
  double get gridUnitBig => onGrid(6);

  /// Grid unit scaled by 8.
  double get gridUnitLarge => onGrid(8);

  double get screenWidthMin => 320;

  double get screenWidthSmall => 432;

  double get screenWidthMedium => 864;
}