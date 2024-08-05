import 'package:flutter/material.dart';
import 'package:student_records/screens/functions/db_functions.dart';
import 'package:student_records/screens/mainscreen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDb();
  runApp(const StudentRecords());
}

class StudentRecords extends StatelessWidget {
  const StudentRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 116, 56, 52),
        ),
        useMaterial3: false,
        splashColor: const Color.fromARGB(255, 128, 81, 81),
        highlightColor: Colors.transparent,
      ),
      home: const Mainscreen(),
    );
  }
}
