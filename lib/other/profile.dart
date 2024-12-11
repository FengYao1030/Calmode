import 'package:calmode/exercise/activity.dart';
import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/link.dart';
import 'package:calmode/auth/sign_in.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calmode/services/diary_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String imageUrl = Other.profileBackground;
  final String imageUrl2 = Other.profileDetailsBackground;
  //final String imageUrl3 = other.profileImage;
  int _selectedIndex = 4;

  final List<Widget> _pages = [
    const HomePage(),
    const MoodHistory(diaryEntries: []),
    const SelfTest(),
    const Activity(),
    const Profile(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      print('Loading user data...');
      print('Current user ID: ${_auth.currentUser?.uid}');

      final doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .get();

      print('Document exists: ${doc.exists}');
      if (doc.exists) {
        print('Document data: ${doc.data()}');
        setState(() {
          userData = doc.data();
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Add a refresh function
  Future<void> _refreshUserData() async {
    await _loadUserData();
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
      body: RefreshIndicator(
        onRefresh: _refreshUserData,
        child: Stack(
          children: [
            // Full-width background image (for AppBar and body)
            Container(
              height: 240, // Adjust height as needed
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                // AppBar with transparent background
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                  ),
                  actions: [
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onSelected: (value) {
                        if (value == 'logout') {
                          // Navigate to the sign-in page
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'logout',
                          child: ListTile(
                            title: Text(
                              'Logout',
                              style: TextStyle(fontSize: 15),
                            ),
                            leading: Icon(Icons.logout, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 220),

                // Profile Details Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 350,
                    height: 350,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl2),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                "Nickname: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  (userData?['nickname'] ?? '')
                                      .trim(), // Display nickname
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(
                                        79, 52, 34, 1), // Brown color
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Will show ellipsis when text overflows
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 170),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Gender: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: userData?['gender'] != null
                                          ? userData!['gender']
                                                  .toString()
                                                  .substring(0, 1)
                                                  .toUpperCase() +
                                              userData!['gender']
                                                  .toString()
                                                  .substring(1)
                                                  .toLowerCase()
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(79, 52, 34, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 170),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Birth Year: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: userData?['birthYear'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(79, 52, 34, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
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


/*
the nickname too long can be 2 lines or set the nickname length on fillup information
*/