import 'package:calmode/test/result_utils.dart';
import 'package:calmode/test/self_test.dart';
import 'package:flutter/material.dart';

class PHQ9Result extends StatelessWidget {
  final int score;

  const PHQ9Result({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final resultData = getResultData(score);

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
                  0.5, // half the screen height
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
}
