import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  final DateTime date;
  final String? content;
  final String? mood;
  final String? moodImage;

  DiaryEntry({
    required this.date,
    this.content,
    this.mood,
    this.moodImage,
  });

  factory DiaryEntry.fromMap(Map<String, dynamic> map, String id) {
    return DiaryEntry(
      date: (map['date'] as Timestamp).toDate(),
      content: map['note'] as String?,
      mood: map['mood'] as String?,
      moodImage: map['moodImage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'note': content,
      'mood': mood,
      'moodImage': moodImage,
    };
  }
}