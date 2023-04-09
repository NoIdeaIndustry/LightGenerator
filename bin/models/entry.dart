import 'dart:io';

import '../utils/file_utils.dart';

class Entry {
  final String platform;
  final String file;
  final int size;
  final String hash;

  // Default constructor
  Entry({
    required this.platform,
    required this.file,
    required this.size,
    required this.hash,
  });

  // Custom constructor from file
  factory Entry.fromFile(final File file) {
    final fullName = FileUtils.getFullname(file.path);
    final platform = FileUtils.getPlatform(fullName);
    return Entry(
      platform: platform,
      file: fullName.replaceAll('$platform\\', '').replaceAll('\\', '/'),
      size: FileUtils.getSize(file),
      hash: FileUtils.getHash(file),
    );
  }

  // Create a json from 'Entry' object
  Map<String, dynamic> toJson() => {
        'platform': platform,
        'file': file,
        'size': size,
        'hash': hash,
      };
}
