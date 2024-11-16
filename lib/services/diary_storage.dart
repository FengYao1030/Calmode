import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:calmode/record_diary/diary_entry_model.dart';

class DiaryStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final List<DiaryEntry> _entries = [];

  static List<DiaryEntry> getEntries() {
    return _entries;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  static void addEntry(DiaryEntry entry) {
    // Remove existing entry for the same day if it exists
    _entries.removeWhere((e) => isSameDay(e.date, entry.date));
    _entries.add(entry);
  }

  Future<List<DiaryEntry>> getDiaryEntries() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        return [];
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('diary_entries')
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => DiaryEntry.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error getting diary entries: $e');
      return [];
    }
  }

  // Add method to save diary entry to Firebase
  Future<void> saveDiaryEntry(DiaryEntry entry) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        debugPrint('No user logged in');
        return;
      }

      // Create a map of the entry data
      final entryData = {
        'date': Timestamp.fromDate(entry.date),
        'mood': entry.mood,
        'note': entry.content,
        'moodImage': entry.moodImage,
      };

      // Get reference to user's diary entries collection
      final userDiaryRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('diary_entries');

      // Query for existing entry on the same day
      final startOfDay = DateTime(entry.date.year, entry.date.month, entry.date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final existingEntryQuery = await userDiaryRef
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThan: Timestamp.fromDate(endOfDay))
          .get();

      if (existingEntryQuery.docs.isNotEmpty) {
        // Update existing entry
        await userDiaryRef.doc(existingEntryQuery.docs.first.id).update(entryData);
      } else {
        // Create new entry
        await userDiaryRef.add(entryData);
      }

      debugPrint('Diary entry saved successfully');
    } catch (e) {
      debugPrint('Error saving diary entry: $e');
      rethrow;
    }
  }

  // Method to get a specific diary entry by date
  Future<DiaryEntry?> getDiaryEntryByDate(DateTime date) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return null;

      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('diary_entries')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThan: Timestamp.fromDate(endOfDay))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return DiaryEntry.fromMap(
          querySnapshot.docs.first.data(),
          querySnapshot.docs.first.id,
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error getting diary entry: $e');
      return null;
    }
  }
} 