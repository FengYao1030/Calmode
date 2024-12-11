import 'package:calmode/other/link.dart';
import 'package:calmode/self_test/confirmation.dart';
import 'package:calmode/self_test/dass_result.dart';
import 'package:calmode/self_test/dass_result_utils.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';

class DASSTest extends StatefulWidget {
  const DASSTest({super.key});

  @override
  _DASSTestState createState() => _DASSTestState();
}

class _DASSTestState extends State<DASSTest> {
  final String imageUrl = Test.confirmationExitTest;
  final List<String> questions = [
    "I found it hard to wind down",
    "I was aware of dryness of my mouth",
    "I couldn't seem to experience any positive feeling at all",
    "I experienced breathing difficulty (eg, excessively rapid breathing, breathlessness absenced of physical exertion)",
    "I found it difficult to work up the initiative to do things",
    "I tended to over-react to situations",
    "I experienced trembling (eg, In the hands)",
    "I felt that I was using a lot of nervous energy",
    "I was worried about situations in which might panic and make a fool of myself",
    "I felt that I had nothing to look forward to",
    "I found myself getting agitated",
    "I found it difficult to relax",
    "I felt down-hearted and blue",
    "I was intolerant of anything that kept me from getting on with what I was doing",
    "I felt I was close to panic",
    "I was unable to become enthusiastic about anything",
    "I felt I wasn't worth much as a person",
    "I felt that I was rather touchy",
    "I was aware of the action of my heart in the absence of physical exertion (eg, sense of heart rate increase, heart missing a beat)",
    "I felt scared without any good reason",
    "I felt that life was meaningless",
  ];

  final List<String> commonOptions = [
    "Did not apply to me at all", // 0
    "Applied to me to some degree, or some of the time", // +1
    "Applied to me to a considerable degree, good part of time", // +2
    "Applied to me very much, or most of the time" // +3
  ];

  late List<List<String>>
      options; // Declare the options list without initialization

  final List<IconData> optionIcons = [
    Icons.favorite_outline_sharp,
    Icons.wb_sunny_outlined,
    Icons.speed_rounded,
    Icons.hourglass_empty_rounded,
  ];

  void _onExitTest(BuildContext context) {
    String imageUrl = Test.confirmationExitTest;
    String message =
        'Are you sure you want to exit the test? Your progress will be lost.';

    showConfirmationDialog(context, imageUrl, message).then((confirmed) {
      if (confirmed == true) {
        // If the user confirmed exit, navigate to the specific page (SelfTest)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SelfTest()),
        );
      }
      // If confirmed is false (cancel), do nothing (just close the dialog)
    });
  }

  List<int> selectedOptions = List.filled(21, -1);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    options = List.generate(21, (index) => commonOptions);
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('At least select an option'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _navigateToResult() {
    // Call calculateDassScore and ensure it returns a Map<String, int>
    Map<String, int> scores = calculateDassScore(selectedOptions);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DASSResult(scores: scores)),
    );
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
              _onExitTest(context);
            }
          },
        ),
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text(
              'DASS Test',
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
      body: SingleChildScrollView(
        // Add this wrapper to make the content scrollable
        child: _buildQuestionCard(currentIndex),
      ),
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
                      _navigateToResult();
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
}
