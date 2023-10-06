import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  applyPadding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);
}
