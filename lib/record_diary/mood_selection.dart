import 'package:calmode/record_diary/mode_selector.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/record_diary/mood_model.dart';
import 'package:calmode/services/diary_storage.dart';
import 'package:flutter/material.dart';
import 'diary_entry_model.dart';

class MoodSelection extends StatefulWidget {
  final String diaryContent;

  const MoodSelection({
    super.key,
    required this.diaryContent,
  });

  @override
  _MoodSelectionState createState() => _MoodSelectionState();
}

class _MoodSelectionState extends State<MoodSelection> {
  int _selectedMoodIndex = 2; // Default to "Neutral"
  final DiaryStorage _diaryStorage = DiaryStorage();

  void _setMood(int index) {
    setState(() {
      _selectedMoodIndex = index;
    });
  }

  void _saveDiaryEntry() async {
    final Mood selectedMood = moods[_selectedMoodIndex];

    final entry = DiaryEntry(
      date: DateTime.now(),
      content: widget.diaryContent,
      mood: selectedMood.label,
      moodImage: selectedMood.imageUrl,
    );

    try {
      await _diaryStorage.saveDiaryEntry(entry);

      if (!mounted) return;

      // Get updated entries and navigate
      final entries = await _diaryStorage.getDiaryEntries();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MoodHistory(diaryEntries: entries),
        ),
      );
    } catch (e) {
      debugPrint('Error saving diary entry: $e');
      // Show error message to user
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save diary entry')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Mood selectedMood = moods[_selectedMoodIndex];

    return Scaffold(
      backgroundColor: selectedMood.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "How are you feeling today?",
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Image.network(
            selectedMood.imageUrl,
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.mood, size: 150);
            },
          ),
          const SizedBox(height: 20),
          Text(
            "I'm Feeling ${selectedMood.label}",
            style: const TextStyle(fontSize: 23, color: Colors.white),
          ),
          const SizedBox(height: 40),
          MoodSelector(
            selectedMoodIndex: _selectedMoodIndex,
            onMoodSelected: _setMood,
            moods: moods,
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 80,
                  left: 30,
                  right: 30), // Adjust for precise positioning
              child: ElevatedButton(
                onPressed: _saveDiaryEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set Mood",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
