import 'dart:io';

import '../utils/config.dart';
import '../utils/file_utils.dart';

class Entry {
  final String fullname;
  final String name;
  final String type;
  final int size;
  final int timestamp;
  final String url;

  // Default constructor
  Entry({
    required this.fullname,
    required this.name,
    required this.type,
    required this.size,
    required this.timestamp,
    required this.url,
  });

  // Custom constructor from file
  factory Entry.fromFile(final File file) {
    final fullName = FileUtils.getFullname(file);
    return Entry(
      fullname: FileUtils.getFullname(file),
      name: FileUtils.getName(fullName),
      type: FileUtils.getExtension(fullName),
      size: FileUtils.getSize(file),
      timestamp: FileUtils.getTimestamp(file),
      url: '${Config.kHostPath}$fullName',
    );
  }
}
