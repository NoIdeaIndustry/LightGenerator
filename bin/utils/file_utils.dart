import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

class FileUtils {
  // get last file modification timestamp
  static int getTimestamp(final File file) {
    return file.lastModifiedSync().millisecondsSinceEpoch;
  }

  // basic hash calculation logic
  static String getHash(final File file) {
    final bytes = file.readAsBytesSync();
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // get the file's size
  static int getSize(final File file) {
    return file.statSync().size;
  }

  // get the file's name without extension
  static String getName(final String fileName) {
    return path.basenameWithoutExtension(fileName);
  }

  // get the file's extension only
  static String getExtension(final String fileName) {
    return path.extension(fileName);
  }

  // get the file's name from full path
  static String getFullname(final File file) {
    return file.path.split('/').last.substring(6);
  }
}
