import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodHistory extends StatelessWidget {
  final List<Map<String, dynamic>> moodData = [
    {'date': DateTime(2024, 10, 1), 'mood': 'Overjoyed', 'emoji': '😊'},
    {'date': DateTime(2024, 10, 2), 'mood': 'Happy', 'emoji': '🙂'},
    {'date': DateTime(2024, 10, 3), 'mood': 'Sad', 'emoji': '😔'},
    {'date': DateTime(2024, 10, 4), 'mood': 'Neutral', 'emoji': '😐'},
    {'date': DateTime(2024, 10, 7), 'mood': 'Depressed', 'emoji': '😞'},
    {'date': DateTime(2024, 10, 10), 'mood': 'Overjoyed', 'emoji': '😊'},
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
            Navigator.pop(context);
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
              itemCount: moodData.length,
              itemBuilder: (context, index) {
                final moodEntry = moodData[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
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
                                  DateFormat('MMM')
                                      .format(moodEntry['date'])
                                      .toUpperCase(), // Month in uppercase
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd')
                                      .format(moodEntry['date']), // Day
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
                        moodEntry['mood'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        moodEntry['emoji'],
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
