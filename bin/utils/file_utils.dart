import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

import 'platform.dart';

class FileUtils {
  // Get last file modification timestamp
  static int getTimestamp(final File file) {
    return file.lastModifiedSync().millisecondsSinceEpoch;
  }

  // Basic hash calculation logic
  static String getHash(final File file) {
    final bytes = file.readAsBytesSync();
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Get the file platform from path
  static String getPlatform(final String fullName) {
    for (final platform in Platform.available) {
      if (fullName.contains(platform.name)) {
        return fullName.substring(0, platform.name.length);
      }
    }

    return 'unknown';
  }

  // Get the file size
  static int getSize(final File file) {
    return file.statSync().size;
  }

  // Get the file name without extension
  static String getName(final String fileName) {
    return path.basenameWithoutExtension(fileName);
  }

  // Get the file extension only
  static String getExtension(final String fileName) {
    return path.extension(fileName);
  }

  // Get the file name from full path
  static String getFullname(final File file) {
    return file.path.split('/').last;
  }
}
