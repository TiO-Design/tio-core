import 'package:flutter/widgets.dart';

void onNextFrame(Function() block) {
  WidgetsBinding.instance.addPostFrameCallback((_) => block());
}
