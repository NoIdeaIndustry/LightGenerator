import 'dart:io';

import '../utils/file_utils.dart';

class Entry {
  final String file;
  final int size;
  final String hash;

  // Default constructor
  Entry({
    required this.file,
    required this.size,
    required this.hash,
  });

  // Custom constructor from file
  factory Entry.fromFile(final File file) {
    final fullName = FileUtils.getFullname(file.path);
    final platform = FileUtils.getPlatform(fullName);
    return Entry(
      file: fullName.replaceAll('$platform\\', '').replaceAll('\\', '/'),
      size: FileUtils.getSize(file),
      hash: FileUtils.getHash(file),
    );
  }

  // Create a json from 'Entry' object
  Map<String, dynamic> toJson() => {
        'file': file,
        'size': size,
        'hash': hash,
      };
}
