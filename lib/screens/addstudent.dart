import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/screens/functions/db_functions.dart';
import 'package:student_records/screens/models/student_model.dart';

class AddStud extends StatefulWidget {
  const AddStud({super.key});

  @override
  State<AddStud> createState() => _AddStudState();
}

class _AddStudState extends State<AddStud> {
  File? _image;
  //final ImagePicker _picker = ImagePicker();
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _batchcontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
              left: 30,
              right: 30,
            ),
            child: ListView(
              children: [
                profileImage(),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name field can not be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: ('Name'),
                              label: const Text('Name ')),
                          controller: _namecontroller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Age field can not be empty';
                            }
                            //  else if (value != int) {
                            //   return ' Age must be in number';
                            // }
                            else {
                              return null;
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: ('Age'),
                            label: const Text('Age'),
                          ),
                          controller: _agecontroller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Batch field can not be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: ('Batch'),
                              label: const Text('Batch')),
                          controller: _batchcontroller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone Number field can not be empty';
                            }
                            //  else if (value != int) {
                            //   return ' Phone Number must be in number';
                            // }
                            else {
                              return null;
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: ('Phone Number'),
                            label: const Text('Phone Number '),
                          ),
                          controller: _numbercontroller,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await addStud();
                      }
                    },
                    label: const Text('Add Student'),
                    icon: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return Center(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => bottomSheet(),
          );
        },
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: const Color.fromARGB(255, 242, 162, 156),
              backgroundImage: _image != null
                  ? FileImage(File(_image!.path))
                  : const AssetImage('assets/images/profileimage.jpg')
                      as ImageProvider,
            ),
            const Positioned(
              bottom: 10,
              right: 15,
              child: Icon(
                Icons.camera_alt,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      color: const Color.fromARGB(255, 97, 48, 44),
      height: 155,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                bottom: 30,
              ),
              child: Text(
                'Profile photo',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 204, 203, 203),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 204, 203, 203),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          color: Color.fromARGB(255, 204, 203, 203),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                TextButton(
                  onPressed: () {
                    clearProfile();
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 204, 203, 203),
                      ),
                      Text(
                        'Remove',
                        style: TextStyle(
                          color: Color.fromARGB(255, 204, 203, 203),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        _image = File(returnImage.path);
      });
      popfunction();
    }
  }

  Future<void> clearProfile() async {
    setState(() {
      _image = null;
    });
    Navigator.of(context).pop();
  }

  Future<void> addStud() async {
    final name = _namecontroller.text;
    final age = _agecontroller.text;
    final batch = _batchcontroller.text;
    final number = _numbercontroller.text;

    Uint8List? imageBytes;
    if (_image != null) {
      imageBytes = await _image!.readAsBytes();
    }

    final studentValues = StudentModel(
        name: name,
        age: age,
        batch: batch,
        phonenumber: number,
        image: imageBytes);

    await addStudDetails(studentValues);
    popfunction();
  }

  void popfunction() {
    Navigator.of(context).pop();
  }
}
