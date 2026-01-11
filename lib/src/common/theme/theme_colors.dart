import 'package:flutter/material.dart';

@immutable
final class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.black,
    required this.red,
    required this.grey,
    required this.grey50,
    required this.blue,
    required this.white,
    required this.success,
    required this.error,
    required this.transparent,
  });

  final Color white;
  final Color success;
  final Color error;
  final Color transparent;
  final Color blue;
  final Color grey50;
  final Color grey;
  final Color red;
  final Color black;

  static const ThemeColors light = ThemeColors(
    white: Colors.white,
    black: Colors.black,
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
    blue: Color(0xFF009FEE),
    grey50: Color(0xFF6B7280),
    grey: Color(0xFFEFEFEF),
    red: Color(0xFFFEE8E9),
  );

  static const ThemeColors dark = ThemeColors(
    red: Color(0xFFFEE8E9),
    black: Colors.black,
    white: Color(0xFF1C1C1E),
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
    blue: Color(0xFF009FEE),
    grey50: Color(0xFF6B7280),
    grey: Color(0xFFEFEFEF),
  );

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? white,
    Color? success,
    Color? error,
    Color? transparent,
    Color? blue,
    Color? grey,
    Color? grey50,
    Color? red,
    Color? black,
  }) => ThemeColors(
    black: black ?? this.black,
    white: white ?? this.white,
    success: success ?? this.success,
    error: error ?? this.error,
    transparent: transparent ?? this.transparent,
    blue: blue ?? this.blue,
    grey50: grey50 ?? this.grey50,
    grey: grey ?? this.grey,
    red: red ?? this.red,
  );

  @override
  ThemeExtension<ThemeColors> lerp(ThemeExtension<ThemeColors>? other, double t) => other is! ThemeColors
      ? this
      : ThemeColors(
          white: Color.lerp(white, other.white, t)!,
          success: Color.lerp(success, other.success, t)!,
          error: Color.lerp(error, other.error, t)!,
          transparent: Color.lerp(transparent, other.transparent, t)!,
          blue: Color.lerp(blue, other.blue, t)!,
          grey50: Color.lerp(grey50, other.grey50, t)!,
          grey: Color.lerp(grey, other.grey, t)!,
          red: Color.lerp(red, other.red, t)!,
          black: Color.lerp(black, other.black, t)!,
        );
}
