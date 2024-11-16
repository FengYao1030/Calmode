import 'package:calmode/other/homepage.dart';
import 'package:calmode/record_diary/diary_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'diary_entry_model.dart';

class MoodHistory extends StatelessWidget {
  final List<DiaryEntry> diaryEntries;

  const MoodHistory({
    super.key,
    required this.diaryEntries,
  });

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
              itemCount: diaryEntries.length,
              itemBuilder: (context, index) {
                final entry = diaryEntries[index];
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
                                        ? DateFormat('MMM').format(entry.date).toUpperCase()
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
    );
  }
}
