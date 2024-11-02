import 'dart:ui';

import 'package:calmode/other/link.dart';
import 'package:flutter/material.dart';

const String imageUrl = mood.depressed;
const String imageUrl2 = mood.sad;
const String imageUrl3 = mood.neutral;
const String imageUrl4 = mood.happy;
const String imageUrl5 = mood.overjoyed;

final List<Mood> moods = [
  Mood("Depressed", imageUrl, const Color.fromRGBO(166, 148, 245, 1)),
  Mood("Sad", imageUrl2, const Color.fromRGBO(237, 126, 28, 1)),
  Mood("Neutral", imageUrl3, const Color.fromRGBO(146, 98, 71, 1)),
  Mood("Happy", imageUrl4, const Color.fromRGBO(255, 206, 92, 1)),
  Mood("Overjoyed", imageUrl5, const Color.fromRGBO(155, 177, 103, 1)),
];

class Mood {
  final String label;
  final String imageUrl;
  final Color backgroundColor;

  Mood(this.label, this.imageUrl, this.backgroundColor);

  Image get image => Image.network(imageUrl);
}
