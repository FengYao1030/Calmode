import 'package:calmode/record_diary/daily_diary.dart';
//import 'package:calmode/record_diary/mood_selection.dart';
import 'package:flutter/material.dart';

class DailyHistory extends StatefulWidget {
  const DailyHistory({super.key});

  @override
  _DailyHistoryState createState() => _DailyHistoryState();
}

class _DailyHistoryState extends State<DailyHistory> {
  final TextEditingController _controller = TextEditingController();
  final int _maxWordCount = 250;

  int _currentWordCount = 0;

  void _updateWordCount() {
    setState(() {
      _currentWordCount = _controller.text
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .length;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateWordCount);
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DailyDiary()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Color.fromRGBO(79, 52, 34, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          children: [
            Text(
              'Daily History',
              style: TextStyle(
                  color: Color.fromRGBO(79, 52, 34, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'urbanist'),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0), // Adjust this value as needed
            child: IconButton(
              icon: const Icon(Icons.edit_note_rounded,
                  color: Color.fromRGBO(79, 52, 34, 1)),
              onPressed: _navigateToNextPage,
              iconSize: 30,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Column(
                  children: [
                    Text(
                      "My Diary",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(79, 52, 34, 1),
                          fontFamily: 'urbanist'),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Review your diary entries from that day",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'urbanist'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: const Color.fromRGBO(79, 52, 34, 1)),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromRGBO(79, 52, 34, 1).withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                      blurStyle:
                          BlurStyle.normal, // Makes the shadow appear inside
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: _controller,
                      maxLines: 10,
                      readOnly: true,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromRGBO(79, 52, 34, 1)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.file_copy_outlined,
                            color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "$_currentWordCount/$_maxWordCount",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
