import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

import 'platform.dart';

class FileUtils {
  // Basic hash calculation logic for file
  static String getHash(final File file) {
    final bytes = file.readAsBytesSync();
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Get the file platform from path
  static String getPlatform(final String fullName) {
    for (final platform in Platform.availablePlatforms) {
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

  // Get the file name from full path
  static String getFullname(final String fullPath) {
    final splits = fullPath.split('\\');
    final platform = Platform.findPlatform(splits);

    return fullPath.substring(fullPath.indexOf(platform));
  }

  // returns all the files inside a directory and sub-directories
  static List<File> getFilesInDirectory(final Directory directory) {
    final List<File> files = [];

    for (final file in directory.listSync()) {
      if (file is Directory) {
        files.addAll(getFilesInDirectory(file));
      } else {
        files.add(file as File);
      }
    }

    return files;
  }
}
