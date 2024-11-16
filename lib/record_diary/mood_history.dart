import 'package:calmode/exercise/exercise.dart';
import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/profile.dart';
import 'package:calmode/record_diary/diary_history.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'diary_entry_model.dart';

class MoodHistory extends StatefulWidget {
  final List<DiaryEntry> diaryEntries;

  const MoodHistory({
    super.key,
    required this.diaryEntries,
  });

  @override
  State<MoodHistory> createState() => _MoodHistoryState();
}

class _MoodHistoryState extends State<MoodHistory> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const HomePage(),
    const MoodHistory(diaryEntries: []),
    const SelfTest(),
    const Exercise(),
    const Profile(),
  ];

  String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
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
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    'My Mood',
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
            padding: const EdgeInsets.only(
                top: 125), // Adjust top padding to move content down
            child: ListView.builder(
              itemCount: widget.diaryEntries.length,
              itemBuilder: (context, index) {
                final entry = widget.diaryEntries[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped entry content: ${entry.content}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyHistory(entry: entry),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(247, 244, 242, 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    entry.date != null
                                        ? DateFormat('MMM')
                                            .format(entry.date)
                                            .toUpperCase()
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    entry.date != null
                                        ? DateFormat('dd').format(entry.date)
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          entry.mood ?? 'No Mood',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Image.network(
                          entry.moodImage ?? '',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.mood, size: 40);
                          },
                        ),
                        subtitle: Text(
                          entry.content ?? 'No content',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => _pages[index]),
          );
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
}
