import 'package:flutter/material.dart';

class BottomAppBarItem {
  const BottomAppBarItem({
    required this.title,
    required this.svgIcon,
    this.color,
  });

  /// Заголовок раздела.
  final String title;

  /// SVG путь до иконки.
  final String svgIcon;

  /// Override над стандартными цветами.
  final Color? color;
}
