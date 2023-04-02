enum Supported { windows, linux, macos }

extension SupportedExtension on Supported {
  String get folder {
    switch (this) {
      case Supported.windows:
        return 'windows';
      case Supported.linux:
        return 'linux';
      case Supported.macos:
        return 'macos';
      default:
        throw Exception('Unsupported platform');
    }
  }
}

class Platform {
  static List<Supported> available = [
    Supported.windows,
    Supported.linux,
    Supported.macos
  ];

  static bool isSupported(final String path) {
    for (final platform in available) {
      if (path.contains(platform.name)) return true;
    }

    return false;
  }
}
