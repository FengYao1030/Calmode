import 'package:calmode/record_diary/mood_selection.dart';
import 'package:flutter/material.dart';

class DailyDiary extends StatefulWidget {
  const DailyDiary({super.key});

  @override
  _DailyDiaryState createState() => _DailyDiaryState();
}

class _DailyDiaryState extends State<DailyDiary> {
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
    if (_currentWordCount > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MoodSelection()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Color.fromRGBO(79, 52, 34, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          children: [
            SizedBox(width: 8), // Space between arrow and title
            Text(
              'Daily Diary',
              style: TextStyle(
                  color: Color.fromRGBO(79, 52, 34, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'urbanist'),
            ),
          ],
        ),
        centerTitle: false,
      ),
      backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    Text(
                      "What's going on?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(79, 52, 34, 1),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Freely write down anything that's on your mind.",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
                      decoration: const InputDecoration(
                        hintText: "I have so much feeling today...",
                        hintStyle:
                            TextStyle(color: Colors.grey), // Hint text color
                        border: InputBorder.none,
                      ),
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
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _currentWordCount > 0 ? _navigateToNextPage : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      disabledBackgroundColor:
                          const Color.fromRGBO(150, 150, 150, 1),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 8), // Space between text and icon
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
