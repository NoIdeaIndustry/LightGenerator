import 'dart:convert';
import 'dart:io';

import 'models/entry.dart';
import 'utils/config.dart';
import 'utils/file_utils.dart';
import 'utils/platform.dart';

void main() {
  final local = _getDirectory();

  // logic to generate for x supported platform
  for (final supported in Platform.availablePlatforms) {
    final platform = supported.name;
    final directory = Directory('${local.path}\\$platform');
    final json = _filesGenerationLogic(directory, platform);
    _fileCreationLogic(directory.parent.parent, platform, json);
  }
}

// Generate json from files in folder
String _filesGenerationLogic(final Directory folder, final String platform) {
  if (!folder.existsSync()) {
    throw ("No folder found... Create the folder or remove the specific platform!");
  }

  final entries = List.empty(growable: true);
  for (final file in folder.listSync()) {
    if (file is Directory) {
      final files = FileUtils.getFilesInDirectory(file);

      for (final dirFile in files) {
        entries.add((Entry.fromFile(dirFile).toJson()));
      }
    } else {
      entries.add((Entry.fromFile(file as File).toJson()));
    }
  }

  return jsonEncode(entries);
}

// Generate file inside folder from json
void _fileCreationLogic(
    final Directory folder, final String platform, final String json) {
  final file = File('${folder.path}/$platform/$platform.json');
  file.writeAsStringSync(json);

  print('File generated in: ${file.path}');
}

// Check availability + get directory
Directory _getDirectory() {
  final directory = Directory('${Directory.current.path}${Config.kFolderPath}');
  if (!directory.existsSync()) {
    print("Specified folder not found... Aborting!");
    exit(0);
  }

  return directory;
}
