import 'package:flutter/material.dart';

/// Centralized color palette for the Driver App.
/// Professional green & white theme with clean contrasts.
class AppColors {
  AppColors._();

  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primaryGreen = Color(0xFF00A86B);
  static const Color primaryGreenLight = Color(0xFF33C48E);
  static const Color primaryGreenDark = Color(0xFF008A57);
  static const Color primaryGreenSurface = Color(0xFFE6F7F0);

  // ── Neutrals ─────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  // ── Text Colors ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // ── Semantic Colors ──────────────────────────────────────────
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color success = Color(0xFF00A86B);
  static const Color warning = Color(0xFFFFA726);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color info = Color(0xFF1976D2);

  // ── Input & Border ───────────────────────────────────────────
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = Color(0xFF00A86B);
  static const Color inputBackground = Color(0xFFFFFFFF);

  // ── Shimmer / Placeholder ────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // ── Status Colors ────────────────────────────────────────────
  static const Color online = Color(0xFF00A86B);
  static const Color offline = Color(0xFF9E9E9E);
}
