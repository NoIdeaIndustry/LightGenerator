import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

import 'platform.dart';

class FileUtils {
  // Get last file modification timestamp
  static int getTimestamp(final File file) {
    return file.lastModifiedSync().millisecondsSinceEpoch;
  }

  // Get last archive file modification timestamp
  static int getArchiveTimestamp(final ArchiveFile file) {
    return file.lastModTime * 10;
  }

  // Basic hash calculation logic for file
  static String getHash(final File file) {
    final bytes = file.readAsBytesSync();
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // Basic hash calculation logic for archive file
  static String getArchiveHash(final ArchiveFile file) {
    final hash = sha256.convert(file.content);
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

  // Get the file name without extension
  static String getName(final String fileName) {
    return path.basenameWithoutExtension(
      fileName.substring(fileName.lastIndexOf('\\')),
    );
  }

  // Get the file extension only
  static String getExtension(final String fileName) {
    return path.extension(fileName);
  }

  // Get the file name from full path
  static String getFullname(final String fullPath) {
    final splits = fullPath.split('\\');
    final platform = Platform.findPlatform(splits);

    return fullPath.substring(fullPath.indexOf(platform));
  }

  // Get the file name from full path
  static String getArchiveFullname(
      final String fullPath, final ArchiveFile file) {
    final split = fullPath.split('\\');
    final platform = fullPath.split('\\').elementAt(split.length - 2);
    return '$platform\\${split.last}\\${file.name.replaceAll('/', '\\')}';
  }

  static List<ArchiveFile> unpackArchive(final File file) {
    final List<ArchiveFile> content = [];

    final bytes = file.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      if (file.isFile) {
        content.add(file);
      }
    }

    return content;
  }

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
