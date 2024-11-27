/*import 'package:calmode/other/link.dart';
import 'package:flutter/material.dart';

class DASSResult extends StatelessWidget {
  final String imageUrl = Test.dassResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () {
            // Handle back button logic
          },
        ),
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              "Result",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(79, 52, 34, 1),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              // Image Placeholder
              Container(
                height: 200,
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Stress Card
              buildScoreCard(
                score: 27,
                title: "Stress",
                description:
                    "Your score indicates severe stress, which may be impacting your well-being. Speaking to a professional or seeking support would be beneficial.",
                color: const Color.fromRGBO(
                    255, 226, 217, 1), // Light peach background
                scoreBackgroundColor:
                    const Color.fromRGBO(243, 105, 42, 1), // Bold orange
              ),
              const SizedBox(height: 25.0),
              // Anxiety Card
              buildScoreCard(
                score: 3,
                title: "Anxiety",
                description:
                    "Normal. Your score indicates that you are experiencing normal levels of anxiety. It's important to maintain your mental well-being.",
                color: const Color.fromRGBO(
                    255, 244, 204, 1), // Light yellow background
                scoreBackgroundColor:
                    const Color.fromRGBO(251, 178, 62, 1), // Bold yellow
              ),
              const SizedBox(height: 25.0),
              // Depression Card
              buildScoreCard(
                score: 24,
                title: "Depression",
                description:
                    "Your score reflects severe depression, which is likely affecting your daily life. It's important to reach out to a professional for further evaluation and support.",
                color: const Color.fromRGBO(233, 227, 255, 1),
                scoreBackgroundColor: const Color.fromRGBO(133, 99, 255, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScoreCard({
    required int score,
    required String title,
    required String description,
    required Color color,
    required Color scoreBackgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, bottom: 10.0, left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: scoreBackgroundColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';

class DASSResult extends StatelessWidget {
  final Map<String, int> scores;

  DASSResult({required this.scores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              "Result",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(79, 52, 34, 1),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),

              // Display scores for Stress, Anxiety and Depression
              buildScoreCard(
                score: scores['Stress Score']!,
                title: "Stress",
                description: "Your score indicates severe stress.",
                color: const Color.fromRGBO(255, 226, 217, 1),
                scoreBackgroundColor: const Color.fromRGBO(243, 105, 42, 1),
              ),

              const SizedBox(height: 25.0),

              buildScoreCard(
                score: scores['Anxiety Score']!,
                title: "Anxiety",
                description: "Normal levels of anxiety.",
                color: const Color.fromRGBO(255, 244, 204, 1),
                scoreBackgroundColor: const Color.fromRGBO(251, 178, 62, 1),
              ),

              const SizedBox(height: 25.0),

              buildScoreCard(
                score: scores['Depression Score']!,
                title: "Depression",
                description: "Your score reflects severe depression.",
                color: const Color.fromRGBO(233, 227, 255, 1),
                scoreBackgroundColor: const Color.fromRGBO(133, 99, 255, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScoreCard(
      {required int score,
      required String title,
      required String description,
      required Color color,
      required Color scoreBackgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
          bottom: 10.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: scoreBackgroundColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:calmode/other/link.dart';
import 'package:calmode/self_test/dass_result_utils.dart';
import 'package:calmode/self_test/self_test.dart';
import 'package:flutter/material.dart';

class DASSResult extends StatelessWidget {
  final Map<String, int> scores;

  DASSResult({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    // Get descriptions
    String depressionDescription =
        getDescription('Depression', scores['Depression Score']!);
    String anxietyDescription =
        getDescription('Anxiety', scores['Anxiety Score']!);
    String stressDescription =
        getDescription('Stress', scores['Stress Score']!);

    const String imageUrl = Test.dassResult;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelfTest()));
          },
        ),
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              "Result",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(79, 52, 34, 1),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              // Image Placeholder
              Container(
                height: 200,
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey[200],
                  image: const DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Stress Card
              buildScoreCard(
                score: scores['Stress Score']!,
                title: "Stress",
                description: stressDescription,
                color: const Color.fromRGBO(
                    255, 226, 217, 1), // Light peach background
                scoreBackgroundColor:
                    const Color.fromRGBO(243, 105, 42, 1), // Bold orange
              ),
              const SizedBox(height: 25.0),
              // Anxiety Card
              buildScoreCard(
                score: scores['Anxiety Score']!,
                title: "Anxiety",
                description: anxietyDescription,
                color: const Color.fromRGBO(
                    255, 244, 204, 1), // Light yellow background
                scoreBackgroundColor:
                    const Color.fromRGBO(251, 178, 62, 1), // Bold yellow
              ),
              const SizedBox(height: 25.0),
              // Depression Card
              buildScoreCard(
                score: scores['Depression Score']!,
                title: "Depression",
                description: depressionDescription,
                color: const Color.fromRGBO(233, 227, 255, 1),
                scoreBackgroundColor: const Color.fromRGBO(133, 99, 255, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScoreCard({
    required int score,
    required String title,
    required String description,
    required Color color,
    required Color scoreBackgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, bottom: 10.0, left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: scoreBackgroundColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
