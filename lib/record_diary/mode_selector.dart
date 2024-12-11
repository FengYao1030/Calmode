import 'package:calmode/record_diary/mood_model.dart';
import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final int selectedMoodIndex;
  final ValueChanged<int> onMoodSelected;
  final List<Mood> moods;

  const MoodSelector({
    super.key,
    required this.selectedMoodIndex,
    required this.onMoodSelected,
    required this.moods,
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
            children: List.generate(moods.length, (index) {
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
                                ? moods[selectedMoodIndex].backgroundColor
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
}
