class Supported {
  final String name;

  Supported(this.name);
}

class Platform {
  static List<Supported> availablePlatforms = [
    Supported('windows'),
    Supported('linux'),
    Supported('macos'),
  ];

  static bool isSupported(final String path) {
    for (final platform in availablePlatforms) {
      if (path.contains(platform.name)) return true;
    }

    return false;
  }

  static String findPlatform(final List<String> list) {
    for (final element in list) {
      for (final platform in availablePlatforms) {
        if (element.contains(platform.name)) {
          return platform.name;
        }
      }
    }

    return 'unknown';
  }
}
