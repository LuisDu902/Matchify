import 'dart:convert' as convert;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Song {
  AudioPlayer audioPlayer = AudioPlayer();
  final String trackName;
  final String artistName;
  final String genre;
  final String previewUrl;
  final String imageUrl;

  bool isPlaying = false;

  Song({
    required this.trackName,
    required this.artistName,
    required this.genre,
    required this.previewUrl,
    required this.imageUrl,
  });

  void play() {
    isPlaying = true;
    audioPlayer.play(UrlSource(previewUrl));
  }

  void pause() {
    isPlaying = false;
    audioPlayer.pause();
  }
}
