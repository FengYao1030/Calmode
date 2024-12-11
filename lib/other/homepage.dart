import 'package:calmode/exercise/activity.dart';
import 'package:calmode/other/link.dart';
import 'package:calmode/other/profile.dart';
import 'package:calmode/record_diary/daily_diary.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/services/diary_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _nickname = '';

  @override
  void initState() {
    super.initState();
    _loadUserNickname();
  }

  Future<void> _loadUserNickname() async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .get();

      if (doc.exists && mounted) {
        setState(() {
          _nickname = doc.data()?['nickname'] ?? 'User';
        });
      }
    } catch (e) {
      debugPrint('Error loading nickname: $e');
    }
  }

  final String imageUrl = Other.homepageIcon;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    MoodHistory(diaryEntries: const []),
    const SelfTest(),
    const Activity(),
    const Profile(),
  ];

  void _navigateToPage(int index) async {
    if (index == 1) {
      // Diary tab
      // Fetch diary entries and navigate to MoodHistory
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

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEE d MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(79, 52, 34, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDate,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, $_nickname!',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Your mental health matters: take the first step today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // "How are you today?" Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How are you today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Take a moment to record your feelings.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DailyDiary()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(
                          155, 177, 104, 1), // Light green color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Record Now',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Self-Test Section
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Self-Test',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 223, 180, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Space between text and image
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      // Take up remaining space for text
                      child: Text(
                        '"Self-Test" is a self-screening test that serves to help each individual determine their mental health status. Among the tests you can take.',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        textAlign:
                            TextAlign.left, // Optional: left align the text
                      ),
                    ),
                    // Image on the right side
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 15),
                        Image.network(
                          imageUrl,
                          height: 60,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 360,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SelfTest()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 191, 31, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Take a Test',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Footer text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Look out for more features coming soon.',
                  style: TextStyle(color: Color.fromRGBO(79, 52, 34, 1)),
                ),
              ),
            ),
          ],
        ),
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
}
