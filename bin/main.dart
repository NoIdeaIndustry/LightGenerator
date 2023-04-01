import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

class Config {
  // the local path from the script parent folder to look for files from
  static final String kFolderPath = "/files";

  // the url to access files from the internet
  static final String kHostPath = "https/exemple.com/Updater/myFiles/";
}

void main() {
  final localDir = Directory(Directory.current.path);

  // get the supposed folder to look for files you want to generate data from
  final folderDir = Directory('${localDir.path}${Config.kFolderPath}');
  if (!folderDir.existsSync()) {
    print("Specified folder not found... Aborting!");
    exit(0);
  }

  final generatedEntries = [];
  for (final file in folderDir.listSync()) {
    if (file is File) {
      final fullName = _getFullname(file);
      final generatedData = {
        'name': _getName(fullName),
        'type': _getExtension(fullName),
        'hash': _getHash(file),
        'size': _getSize(file),
        'timestamp': _getStamp(file),
        'url': '${Config.kHostPath}$fullName'
      };
      generatedEntries.add(generatedData);
    }
  }

  // encode the entries in a json file
  final json = jsonEncode(generatedEntries);

  // create a special folder to hold the generated file
  final generatedDir = Directory('${folderDir.path}/generated');
  generatedDir.createSync();

  // generate the final file inside the special folder
  final generatedFile = File('${generatedDir.path}/generated.json');
  generatedFile.writeAsStringSync(json);

  print('File generated in: ${generatedFile.path}');
}

String _getStamp(final File file) {
  // get last file modification timestamp
  return file.lastModifiedSync().millisecondsSinceEpoch.toString();
}

String _getHash(final File file) {
  // basic hash calculation logic
  final bytes = file.readAsBytesSync();
  final hash = sha256.convert(bytes);
  return hash.toString();
}

String _getSize(final File file) {
  // get the file's size
  return file.statSync().size.toString();
}

String _getName(final String fileName) {
  // get the file's name without extension
  return path.basenameWithoutExtension(fileName);
}

String _getExtension(final String fileName) {
  // get the file's extension only
  return path.extension(fileName);
}

String _getFullname(final File file) {
  // get the file's name from full path
  return file.path.split('/').last.substring(6);
}
