import 'package:flutter/material.dart';

class ColorResolver {
  static Color resolve(String key) {
    // Couleur hex directe ex: "1D4ED8"
    try {
      return Color(int.parse('FF$key', radix: 16));
    } catch (_) {
      return const Color(0xFF1D4ED8);
    }
  }
}