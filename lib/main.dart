import 'package:calmode/other/homepage.dart';
import 'package:calmode/self_test/dass_result.dart';
import 'package:calmode/self_test/dass_test.dart';
import 'package:calmode/services/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calmode',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DASSTest(),
    );
  }
}


/*
- snackbar (check need or not)

----------------------------------------
Advanced
- my mood allow user to delete record
- to view specific date diary
- to select specific date add a diary

- DASS Test /

- add more audio
- apply suitable API

- community (optional)

- profile add profile picture (optional)
*/

