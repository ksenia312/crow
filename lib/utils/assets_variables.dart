import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';

enum AppAssets { images, icons, figures, loading, spinner}

String getAsset(AppAssets folder, [String fileName='']) {
  var theme = AppTheme();
  switch (folder) {
    case AppAssets.images:
      return 'assets/images/' + fileName;
    case AppAssets.icons:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/icons/icon_light.svg'
          : 'assets/svg/icons/icon_dark.svg';
    case AppAssets.figures:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/figures_light_theme/' + fileName
          : 'assets/svg/figures_dark_theme/' + fileName;
    case AppAssets.loading:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/loading/loading_circle_light.svg'
          : 'assets/svg/loading/loading_circle_dark.svg';
    case AppAssets.spinner:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/spinners/spinner_light.svg'
          : 'assets/svg/spinners/spinner_dark.svg';
  }
}
