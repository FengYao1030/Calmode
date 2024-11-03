import 'dart:ui';
import 'package:calmode/other/link.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> getResultData(int score) {
  if (score <= 4) {
    return {
      'title': 'Minimal or None',
      'description':
          'Your results suggest little to no depression. Keep taking care of your mental health.',
      'backgroundColor': const Color(0xFFD8E6CD),
      'illustrationPath': test.minimalOrNone,
    };
  } else if (score <= 9) {
    return {
      'title': 'Mild',
      'description':
          'You’re showing mild symptoms. Consider some self-care, and monitor how you feel.',
      'backgroundColor': const Color(0xFFFDE2C5),
      'illustrationPath': test.mild,
    };
  } else if (score <= 14) {
    return {
      'title': 'Moderate',
      'description':
          'Your score indicates moderate symptoms. It might help to talk to a professional.',
      'backgroundColor': const Color(0xFFFAC9A3),
      'illustrationPath': test.moderate,
    };
  } else if (score <= 19) {
    return {
      'title': 'Moderately Severe',
      'description':
          'These symptoms are more serious and may impact your daily life. Seeking help is important.',
      'backgroundColor': const Color(0xFFE4D2F5),
      'illustrationPath': test.moderatelySevere,
    };
  } else {
    return {
      'title': 'Severe',
      'description':
          'Your symptoms are severe. Please talk to a healthcare professional as soon as possible.',
      'backgroundColor': const Color(0xFFEAD2CF),
      'illustrationPath': test.severe, // Placeholder for severe image path
    };
  }
}
