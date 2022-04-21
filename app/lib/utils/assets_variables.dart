enum AppAssets {figures, icons, images}

String getAsset(AppAssets folder, String fileName) {
  switch (folder){
    case AppAssets.figures:
      return 'assets/files/figures/' + fileName;
    case AppAssets.icons:
      return 'assets/files/icons/' + fileName;
    case AppAssets.images:
      return 'assets/images/' + fileName;
  }
}