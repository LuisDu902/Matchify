import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:matchify/song/song.dart';

class Playlist {
  final String name;
  final List<Song> songs;

  Playlist({required this.name, required this.songs});
}
