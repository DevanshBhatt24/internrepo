
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getTemporaryDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/feeds.txt');
}

Future<File> writeFeed(List feed) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$feed');
}

// Future<List> readFeed() async {
//   try {
//     final file = await _localFile;

//     // Read the file
//     final contents = await file.readAsString();

//     return int.parse(contents);
//   } catch (e) {
//     // If encountering an error, return 0
//     return 0;
//   }
// }