import 'dart:io';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:matchify/backend/song.dart';

Future<void> export(List<Song> songs,String playlistName) async {
    List<List<dynamic>> rows = [];

  // add header row
  rows.add(['Track Name', 'Artist Name', 'Genre', 'Preview URL', 'Image URL']);

  // add data rows
  for (var song in songs) {
    rows.add([song.trackName, song.artistName, song.genre, song.previewUrl, song.imageUrl]);
  }
  String csv = const ListToCsvConverter().convert(rows);

  String dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  String file = "$dir";

  File f = File("$file/$playlistName.csv");

  f.writeAsString(csv);
}