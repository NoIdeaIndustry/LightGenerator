import 'dart:io';

import 'package:archive/archive.dart';

import '../utils/config.dart';
import '../utils/file_utils.dart';

class Entry {
  final String platform;
  final String fullname;
  final String name;
  final String type;
  final int size;
  final int timestamp;
  final String hash;
  final String url;

  // Default constructor
  Entry({
    required this.platform,
    required this.fullname,
    required this.name,
    required this.type,
    required this.size,
    required this.timestamp,
    required this.hash,
    required this.url,
  });

  // Custom constructor from file
  factory Entry.fromFile(final File file) {
    final fullName = FileUtils.getFullname(file.path);
    final platform = FileUtils.getPlatform(fullName);
    return Entry(
      platform: platform,
      fullname: fullName.replaceAll('$platform\\', ''),
      name: FileUtils.getName(fullName),
      type: FileUtils.getExtension(fullName),
      size: FileUtils.getSize(file),
      hash: FileUtils.getHash(file),
      timestamp: FileUtils.getTimestamp(file),
      url: '${Config.kHostPath}${Config.kFolderPath}/$fullName'
          .replaceAll('\\', '/'),
    );
  }

  /*factory Entry.fromArchiveFile(final String fullPath, final ArchiveFile file) {
    final archiveName = fullPath.substring(fullPath.lastIndexOf('\\') + 1);
    final fullName = FileUtils.getArchiveFullname(fullPath, file);
    final platform = FileUtils.getPlatform(fullName);
    return Entry(
      platform: platform,
      fullname: fullName.replaceAll('$platform\\$archiveName', ''),
      name: FileUtils.getName(fullName),
      type: FileUtils.getExtension(fullName),
      size: file.size,
      hash: FileUtils.getArchiveHash(file),
      timestamp: FileUtils.getArchiveTimestamp(file),
      url: '${Config.kHostPath}${Config.kFolderPath}/$fullName',
    );
  }*/

  // Create a json from 'Entry' object
  Map<String, dynamic> toJson() => {
        'platform': platform,
        'fullname': fullname,
        'name': name,
        'type': type,
        'size': size,
        'timestamp': timestamp,
        'hash': hash,
        'url': url,
      };
}
