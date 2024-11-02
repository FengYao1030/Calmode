import 'package:calmode/other/link.dart';
import 'package:calmode/screens/sign_in.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String imageUrl = other.profileBackground;
  final String imageUrl2 = other.profileDetailsBackground;
  //final String imageUrl3 = other.profileImage;
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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

              // Profile Picture with Overlap
              /*Positioned(
                top: 170,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imageUrl3),
                ),
              ),*/

              // Three-Dot Menu for Logout
              /*Positioned(
                top: 240,
                right: 10,
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onSelected: (value) {
                    if (value == 'logout') {
                      // Navigate to the sign-in page
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.brown),
                        title: Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),*/

              const SizedBox(height: 200),

              // Profile Name
              /*const Text(
                'Shambhavi Mishra',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),*/

              const SizedBox(height: 20),

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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns text to the left
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Nickname",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 30), // Spacing between each text
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Birth Year",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _buildBottomNavItem(Icons.house_outlined, 'Home', 0),
          _buildBottomNavItem(Icons.lightbulb_outline_rounded, 'Test', 1),
          _buildBottomNavItem(Icons.directions_walk_outlined, 'Exercise', 2),
          _buildBottomNavItem(Icons.person_outline_outlined, 'Profile', 3),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown.withOpacity(0.6),
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
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _selectedIndex == index
            ? Colors.brown.withOpacity(0.2)
            : Colors.transparent,
      ),
      child: Icon(icon, color: Colors.brown),
    );
  }
}
