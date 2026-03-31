import 'package:flutter/material.dart';

class IconResolver {
  static const _icons = <String, IconData>{
    'laptop': Icons.laptop,
    'smartphone': Icons.smartphone,
    'print': Icons.print,
    'keyboard': Icons.keyboard,
    'monitor': Icons.monitor,
    'router': Icons.router,
    'camera': Icons.camera_alt,
    'tablet': Icons.tablet,
    'headphones': Icons.headphones,
    'mouse': Icons.mouse,
    'desktop': Icons.desktop_windows,
    'printer': Icons.print,
  };

  static IconData resolve(String key) {
    return _icons[key] ?? Icons.devices_other;
  }
}