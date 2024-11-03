import 'package:calmode/other/link.dart';
import 'package:calmode/test/self_test.dart';
import 'package:flutter/material.dart';

class PHQ9Result extends StatelessWidget {
  final int score;

  const PHQ9Result({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final resultData = _getResultData(score);

    return Scaffold(
      backgroundColor: resultData['backgroundColor'],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 220,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Set to half the screen height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(resultData['illustrationPath']),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelfTest()));
                  },
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Score',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      score.toString(),
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(79, 52, 34, 1),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      resultData['title'],
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(79, 52, 34, 1)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      resultData['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getResultData(int score) {
    if (score <= 4) {
      return {
        'title': 'Minimal or None',
        'description':
            'Your results suggest little to no depression. Keep taking care of your mental health.',
        'backgroundColor': const Color(0xFFD8E6CD),
        'illustrationPath': test.minimalOrNone,
      };
    } else if (score <= 9) {
      return {
        'title': 'Mild',
        'description':
            'You’re showing mild symptoms. Consider some self-care, and monitor how you feel.',
        'backgroundColor': const Color(0xFFFDE2C5),
        'illustrationPath': test.mild,
      };
    } else if (score <= 14) {
      return {
        'title': 'Moderate',
        'description':
            'Your score indicates moderate symptoms. It might help to talk to a professional.',
        'backgroundColor': const Color(0xFFFAC9A3),
        'illustrationPath': test.moderate,
      };
    } else if (score <= 19) {
      return {
        'title': 'Moderately Severe',
        'description':
            'These symptoms are more serious and may impact your daily life. Seeking help is important.',
        'backgroundColor': const Color(0xFFE4D2F5),
        'illustrationPath': test.moderatelySevere,
      };
    } else {
      return {
        'title': 'Severe',
        'description':
            'Your symptoms are severe. Please talk to a healthcare professional as soon as possible.',
        'backgroundColor': const Color(0xFFEAD2CF),
        'illustrationPath': test.severe, // Placeholder for severe image path
      };
    }
  }
}
