import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/profile.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';
import 'package:calmode/other/link.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  final List<Map<String, String>> audioList = [
    {'title': 'Running Day', 'image': Audio.runningDay},
    {'title': 'Forest Waterfall', 'image': Audio.forestWaterfall},
    {'title': 'Ocean Sea', 'image': Audio.oceanSea},
  ];
  final String imageUrl = Audio.earphone;
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const HomePage(),
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
        backgroundColor: const Color.fromRGBO(237, 126, 28, 1),
      ),
      body: Column(
        children: [
          // Header
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(237, 126, 28, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  'Exercise',
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
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                //color: const Color.fromRGBO(246, 223, 180, 1),
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
                      'Take a moment to listen to this relaxing audio. Find a quiet place, close your eyes, and focus on the sound to help calm your mind and body.',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      textAlign:
                          TextAlign.left, // Optional: left align the text
                    ),
                  ),
                  // Image on the right side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 40),
                      Image.network(
                        imageUrl,
                        height: 50,
                        width: 70,
                        //fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          const Row(
            children: [
              SizedBox(width: 20),
              Text(
                'All Audio',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Audio List Section
          Expanded(
            child: ListView.builder(
              itemCount: audioList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    color: Colors.white,
                    child: SizedBox(
                      height: 100, // Adjust height as needed
                      width:
                          double.infinity, // Set width to fill available space
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Adjust padding
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment
                                  .center, // Center align for the Stack
                              children: [
                                CircleAvatar(
                                  radius:
                                      40, // Adjust the radius for the avatar size
                                  backgroundImage:
                                      NetworkImage(audioList[index]['image']!),
                                ),
                                const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 45, // Adjust the size of the play icon
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                audioList[index]['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(79, 52, 34, 1),
                                ),
                              ),
                            ),
                          ],
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
          _buildBottomNavItem(Icons.lightbulb_outline_rounded, 'Test', 1),
          _buildBottomNavItem(Icons.directions_walk_outlined, 'Exercise', 2),
          _buildBottomNavItem(Icons.person_outline_outlined, 'Profile', 3),
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
