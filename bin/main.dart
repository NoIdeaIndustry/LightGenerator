import 'dart:convert';
import 'dart:io';

import 'models/entry.dart';
import 'utils/config.dart';

void main() {
  final directory = _getDirectory();
  _fileCreationLogic(directory, _filesGenerationLogic(directory));
}

// Generate json from files in folder
String _filesGenerationLogic(final Directory folder) {
  final entries = List.empty(growable: true);
  for (final file in folder.listSync()) {
    if (file is File) {
      entries.add(Entry.fromFile(file));
    }
  }

  return jsonEncode(entries);
}

// Generate file inside folder from json
void _fileCreationLogic(final Directory folder, final String json) {
  final directory = Directory('${folder.path}/generated');
  directory.createSync();

  final file = File('${directory.path}/generated.json');
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
