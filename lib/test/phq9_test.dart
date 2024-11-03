import 'package:calmode/other/link.dart';
import 'package:calmode/test/phq9_result.dart';
import 'package:calmode/test/result_utils.dart';
//import 'package:calmode/test/result.dart';
import 'package:calmode/test/self_test.dart';
import 'package:flutter/material.dart';

class PHQ9Test extends StatefulWidget {
  const PHQ9Test({super.key});

  @override
  _PHQ9TestState createState() => _PHQ9TestState();
}

class _PHQ9TestState extends State<PHQ9Test> {
  final String imageUrl = test.confirmationExit;
  final List<String> questions = [
    "Little interest or pleasure in doing things",
    "Feeling down, depressed, or hopeless",
    "Trouble falling asleep, staying asleep, or sleeping too much",
    "Feeling tired or having little energy",
    "Poor appetite or overeating",
    "Feeling bad about yourself or that you are a failure",
    "Trouble concentrating on things, such as reading or watching TV",
    "Moving or speaking so slowly that others could notice",
    "Thoughts that you would be better off dead or hurting yourself"
  ];

  final List<List<String>> options = [
    [
      "Not at all", // 0
      "Several days", // +1
      "More than half the days", // +2
      "Nearly every day" // +3
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
    [
      "Not at all",
      "Several days",
      "More than half the days",
      "Nearly every day"
    ],
  ];

  final List<IconData> optionIcons = [
    Icons.favorite_outline_sharp,
    Icons.wb_sunny_outlined,
    Icons.speed_rounded,
    Icons.hourglass_empty_rounded,
  ];

  List<int> selectedOptions = List.filled(9, -1);
  int currentIndex = 0;

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("At least select an option"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  int _calculateTotalScore() {
    int totalScore = 0;
    for (var selectedOption in selectedOptions) {
      if (selectedOption != -1) {
        totalScore += selectedOption; // 0, 1, 2, or 3 based on option selected
      }
    }
    return totalScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 244, 242, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Color.fromRGBO(79, 52, 34, 1)),
          onPressed: () {
            if (currentIndex > 0) {
              setState(() {
                currentIndex--; // Go to the previous question
              });
            } else {
              _showConfirmationDialog(); // Show confirmation if on the first question
            }
          },
        ),
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text(
              'PHQ-9 Test',
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
      body: _buildQuestionCard(currentIndex),
    );
  }

  Widget _buildQuestionCard(int questionIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "(${questionIndex + 1} of ${questions.length})",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(146, 98, 71, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Center(
            child: Text(
              questions[questionIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(79, 52, 34, 1),
              ),
            ),
          ),
          const SizedBox(height: 50),
          ...options[questionIndex].asMap().entries.map((entry) {
            int optionIndex = entry.key;
            String optionText = entry.value;
            return _buildOption(optionText, questionIndex, optionIndex);
          }),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 145, vertical: 15),
              ),
              onPressed: () {
                if (selectedOptions[currentIndex] == -1) {
                  _showSnackbar(); // Show Snackbar if no option is selected
                } else {
                  setState(() {
                    if (currentIndex < questions.length - 1) {
                      currentIndex++; // Move to the next question
                    } else {
                      int totalScore = _calculateTotalScore();
                      getResultData(totalScore);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PHQ9Result(score: totalScore),
                        ),
                      );
                    }
                  });
                }
              },
              child: Text(
                currentIndex < questions.length - 1 ? 'Continue' : 'Finish',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption(String optionText, int questionIndex, int optionIndex) {
    bool isSelected = selectedOptions[questionIndex] == optionIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptions[questionIndex] = optionIndex;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(155, 177, 104, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey,
            width: 1.5,
          ),
        ),
        child: ListTile(
          leading: Icon(optionIcons[optionIndex],
              color: isSelected
                  ? Colors.white
                  : const Color.fromRGBO(79, 52, 34, 1)),
          title: Text(
            optionText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : const Color.fromRGBO(79, 52, 34, 1)),
          ),
          trailing: Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                imageUrl,
                height: 250,
                width: 280,
              ),
              const SizedBox(height: 20),
              const Text(
                "Are you sure want to exit the test? The current status will be lost.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(79, 52, 34, 1),
                ),
              ),
              const SizedBox(height: 20),
              // Exit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SelfTest()),
                ),
                child: const Text(
                  "Exit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
