import 'package:flutter/material.dart';
import 'package:student_records/screens/models/student_model.dart';

class DetailedStud extends StatelessWidget {
  final StudentModel student;

  const DetailedStud({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: CircleAvatar(
                  backgroundImage: student.image != null
                      ? MemoryImage(student.image!)
                      : const AssetImage('assets/images/profileimage.jpg'),
                  radius: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                child: Row(
                  children: [
                    const Text(
                      'Name: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
                    ),
                    Text(
                      student.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                child: Row(
                  children: [
                    const Text(
                      'Age: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
                    ),
                    Text(
                      student.age,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                child: Row(
                  children: [
                    const Text(
                      'Batch: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
                    ),
                    Text(
                      student.batch,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                child: Row(
                  children: [
                    const Text(
                      'Phone Number: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
                    ),
                    Text(
                      student.phonenumber,
                      style: const TextStyle(fontSize: 20),
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
