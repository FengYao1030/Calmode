import 'package:calmode/exercise/exercise.dart';
import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/profile.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/self_test/dass_test.dart';
import 'package:calmode/self_test/phq9_test.dart';
import 'package:flutter/material.dart';
import 'package:calmode/services/diary_storage.dart';

class SelfTest extends StatefulWidget {
  const SelfTest({super.key});

  @override
  _SelfTestState createState() => _SelfTestState();
}

class _SelfTestState extends State<SelfTest> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const HomePage(),
    MoodHistory(diaryEntries: const []),
    const SelfTest(),
    const Exercise(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(79, 52, 34, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text(
                    'Self-Test',
                    style: TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTestCard(
                  context,
                  title: 'Patient Health Questionnaire (PHQ-9)',
                  description:
                      'PHQ-9 consist of 9-question instrument to screen for presence and severity of depression. For diagnosis, we recommend you to consult the professional for further assessment.',
                  color: const Color.fromRGBO(237, 126, 28, 1),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PHQ9Test()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildTestCard(
                  context,
                  title: 'Depression, Anxiety & Stress Scale (DASS)',
                  description:
                      'DASS is 21-item questionnaires designed to measure the current mental health and emotional states, identifying Depression, Anxiety or Stress.',
                  color: const Color.fromRGBO(155, 177, 103, 1),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DASSTest()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToPage(index);
        },
        items: [
          _buildBottomNavItem(Icons.house_outlined, 'Home', 0),
          _buildBottomNavItem(Icons.book_outlined, 'Diary', 1),
          _buildBottomNavItem(Icons.lightbulb_outline_rounded, 'Test', 2),
          _buildBottomNavItem(Icons.directions_walk_outlined, 'Exercise', 3),
          _buildBottomNavItem(Icons.person_outline_outlined, 'Profile', 4),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown.withOpacity(0.6),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildNavIcon(icon, index),
      label: label, // Always show the label
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.brown : Colors.transparent,
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.brown.withOpacity(0.6),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context,
      {required String title,
      required String description,
      required Color color,
      required VoidCallback onPressed}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: onPressed,
                child: const Text(
                  'Start Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int index) async {
    if (index == 1) {
      // Diary tab
      final diaryStorage = DiaryStorage();
      final entries = await diaryStorage.getDiaryEntries();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MoodHistory(diaryEntries: entries),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }
}
