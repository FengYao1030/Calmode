import 'package:calmode/other/link.dart';
import 'package:calmode/record_diary/mode_selector.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/record_diary/mood_model.dart';
import 'package:calmode/services/diary_storage.dart';
import 'package:flutter/material.dart';
import 'diary_entry_model.dart';

/*const String imageUrl = mood.depressed;
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
];*/

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

/*class MoodSelector extends StatelessWidget {
  final int selectedMoodIndex;
  final ValueChanged<int> onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMoodIndex,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_moods.length, (index) {
              return GestureDetector(
                onTap: () => onMoodSelected(index),
                child: Row(
                  children: [
                    // Curved connector between dots
                    if (index != 0)
                      Container(
                        width: 30,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    // Mood dot
                    Container(
                      width: index == selectedMoodIndex ? 40 : 28,
                      height: index == selectedMoodIndex ? 40 : 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == selectedMoodIndex
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        border: index == selectedMoodIndex
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == selectedMoodIndex
                                ? _moods[selectedMoodIndex].backgroundColor
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}*/
