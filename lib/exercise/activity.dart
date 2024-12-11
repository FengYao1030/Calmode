import 'package:calmode/other/homepage.dart';
import 'package:calmode/other/profile.dart';
import 'package:calmode/record_diary/mood_history.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:calmode/youtube/youTubeEmbeddedPlayerAPI.dart';
import 'package:flutter/material.dart';
import 'package:calmode/other/link.dart';
import 'package:calmode/services/diary_storage.dart';
import 'package:audioplayers/audioplayers.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final AudioPlayer audioPlayer = AudioPlayer();
  int? playingIndex;
  final List<Map<String, String>> audioList = [
    {
      'title': 'Raining Day',
      'image': Audio.rainingDay,
      'audio': Mp3.rainingSound
    },
    {
      'title': 'Forest Waterfall',
      'image': Audio.forestWaterfall,
      'audio': Mp3.waterfallSound
    },
    {'title': 'Ocean Sea', 'image': Audio.oceanSea, 'audio': Mp3.oceanSeaSound},
    // add other audio
    //{'title': 'Ocean Sea', 'image': Audio.oceanSea, 'audio': Mp3.oceanSeaSound},
  ];
  final String imageUrl = Audio.earphone;
  int _selectedIndex = 3;

  final List<Widget> _pages = [
    const HomePage(),
    const MoodHistory(diaryEntries: []),
    const SelfTest(),
    const Activity(),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    // Make it rotate continuously
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> toggleAudio(int index) async {
    if (playingIndex == index) {
      await audioPlayer.pause();
      _animationController.stop();
      setState(() {
        playingIndex = null;
      });
    } else {
      if (playingIndex != null) {
        await audioPlayer.stop();
      }
      await audioPlayer.play(UrlSource(audioList[index]['audio']!));
      _animationController.forward();
      setState(() {
        playingIndex = index;
      });
    }
  }

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
                  'Activity',
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              'Take a moment to listen to this relaxing audio. Find a quiet place, close your eyes, and focus on the sound to help calm your mind and body.',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 40),
                              Image.network(
                                imageUrl,
                                height: 50,
                                width: 70,
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
                  ListView.builder(
                    shrinkWrap:
                        true, // Ensure ListView fits inside SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                    itemCount: audioList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      playingIndex == index
                                          ? RotationTransition(
                                              turns: _animationController,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                    audioList[index]['image']!),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(
                                                  audioList[index]['image']!),
                                            ),
                                      GestureDetector(
                                        onTap: () => toggleAudio(index),
                                        child: Icon(
                                          playingIndex == index
                                              ? Icons.pause_circle_filled
                                              : Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 45,
                                        ),
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

                  const SizedBox(height: 30),
                  // Video Section Below Audio List
                  const Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Play Video',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const SizedBox(
                      height: 530, width: 350, // Adjust the height as needed
                      child: YouTubeEmbeddedPlayerAPI(),
                    ),
                  ),
                ],
              ),
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
          _buildBottomNavItem(Icons.directions_walk_outlined, 'Activity', 3),
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
      label: label,
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
