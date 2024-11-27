/*import 'package:flutter/material.dart';

class CalculateDassScorePage extends StatelessWidget {
  final List<int> answers;

  // Constructor to accept answers
  CalculateDassScorePage({required this.answers});

  // dass_result_utils.dart
  Map<String, int> calculateDassScore(List<int> answers) {
    // Group the answers according to DASS subscales
    List<int> depression = answers.sublist(0, 7);
    List<int> anxiety = answers.sublist(7, 14);
    List<int> stress = answers.sublist(14, 21);

    // Calculate scores for each scale (sum of answers)
    int depressionScore = depression.reduce((a, b) => a + b);
    int anxietyScore = anxiety.reduce((a, b) => a + b);
    int stressScore = stress.reduce((a, b) => a + b);

    return {
      'Depression Score': depressionScore,
      'Anxiety Score': anxietyScore,
      'Stress Score': stressScore,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Get the DASS score calculation
    Map<String, int> scores = calculateDassScore(answers);

    return Scaffold(
      appBar: AppBar(title: const Text("DASS Test Score")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your DASS Test Scores:",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text("Depression Score: ${scores['Depression Score']}",
                style: const TextStyle(fontSize: 18)),
            Text("Anxiety Score: ${scores['Anxiety Score']}",
                style: const TextStyle(fontSize: 18)),
            Text("Stress Score: ${scores['Stress Score']}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Test Page'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

Map<String, int> calculateDassScore(List<int> answers) {
  // Initialize scores for each category
  int stressScore = 0;
  int anxietyScore = 0;
  int depressionScore = 0;

  // Calculate scores based on specific questions for each category
  // Stress: Q1 (0), Q6 (5), Q8 (7), Q11 (10), Q12 (11), Q14 (13), Q18 (17)
  stressScore += answers[0]; // Q1
  stressScore += answers[5]; // Q6
  stressScore += answers[7]; // Q8
  stressScore += answers[10]; // Q11
  stressScore += answers[11]; // Q12
  stressScore += answers[13]; // Q14
  stressScore += answers[17]; // Q18

  // Anxiety: Q2 (1), Q4 (3), Q7 (6), Q9 (8), Q15 (14), Q19 (18), Q20 (19)
  anxietyScore += answers[1]; // Q2
  anxietyScore += answers[3]; // Q4
  anxietyScore += answers[6]; // Q7
  anxietyScore += answers[8]; // Q9
  anxietyScore += answers[14]; // Q15
  anxietyScore += answers[18]; // Q19
  anxietyScore += answers[19]; // Q20

  // Depression: Q3 (2), Q5 (4), Q10 (9), Q13 (12), Q16 (15), Q17 (16), Q21 (20)
  depressionScore += answers[2]; // Q3
  depressionScore += answers[4]; // Q5
  depressionScore += answers[9]; // Q10
  depressionScore += answers[12]; // Q13
  depressionScore += answers[15]; // Q16
  depressionScore += answers[16]; // Q17
  depressionScore += answers[20]; // Q21

  return {
    'Depression Score': depressionScore,
    'Anxiety Score': anxietyScore,
    'Stress Score': stressScore,
  };
}

// Get description based on score
String getDescription(String category, int score) {
  if (category == 'Stress') {
    if (score >= 0 && score <= 7) {
      return "Low level of stress. Continue practicing a healthy lifestyle and self-care.";
    }
    if (score >= 8 && score <= 9) {
      return "Mild level of stress. Try relaxation techniques like deep breathing, light exercise, or mindfulness.";
    }
    if (score >= 10 && score <= 13) {
      return "Moderate level of stress. Engage in stress management techniques such as yoga or meditation. Consider speaking to a trusted friend or counselor.";
    }
    if (score >= 14 && score <= 17) {
      return "Severe levels of stress. Prioritize self-care. Reduce stressful activities and seek guidance from a mental health professional if necessary.";
    }
    if (score >= 18) {
      return "Extremely Severe levels of stress. Seek immediate professional help. Develop a structured stress-reduction plan with a therapist or counselor.";
    }
  } else if (category == 'Anxiety') {
    if (score >= 0 && score <= 4) {
      return "Low level of anxiety. Maintain good mental health habits, like regular exercise and a balanced diet.";
    }
    if (score >= 5 && score <= 6) {
      return "Mild level of anxiety. Practice calming activities, such as listening to soothing music or engaging in hobbies.";
    }
    if (score >= 7 && score <= 8) {
      return "Moderate level of anxiety. Try mindfulness exercises, such as progressive muscle relaxation, and consider short-term therapy if anxiety persists.";
    }
    if (score >= 9 && score <= 10) {
      return "Severe levels of anxiety. Avoid triggers where possible and consult a therapist or counselor to learn coping strategies.";
    }
    if (score >= 11) {
      return "Extremely Severe levels of anxiety. Seek professional intervention. Therapy or medication may be necessary.";
    }
  } else if (category == 'Depression') {
    if (score >= 0 && score <= 5) {
      return "Low level of depression. Focus on maintaining positive activities and social interactions.";
    }
    if (score >= 6 && score <= 7) {
      return "Mild level of depression. Practice gratitude journaling and light physical activity to elevate mood.";
    }
    if (score >= 8 && score <= 10) {
      return "Moderate level of depression. Stay connected to friends and family, and consider reaching out to a counselor for early support.";
    }
    if (score >= 11 && score <= 14) {
      return "Severe levels of depression. Seek therapy or counseling. Engage in structured daily routines and physical activities to improve emotional balance.";
    }
    if (score >= 15) {
      return "Extremely Severe levels of depression. Seek immediate professional intervention. A combination of therapy and possibly medication may be required to address these symptoms effectively.";
    }
  }
  return "Invalid Score";
}
