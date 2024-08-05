import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/screens/functions/db_functions.dart';
import 'package:student_records/screens/models/student_model.dart';

class EditStudent extends StatefulWidget {
  final StudentModel newstudent;

  const EditStudent({super.key, required this.newstudent});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  // final ImagePicker _picker = ImagePicker();
  late TextEditingController _namecontroller;

  late TextEditingController _agecontroller;
  late TextEditingController _batchcontroller;
  late TextEditingController _numbercontroller;
  File? _selectImage;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController(text: widget.newstudent.name);
    _agecontroller = TextEditingController(text: widget.newstudent.age);
    _batchcontroller = TextEditingController(text: widget.newstudent.batch);
    _numbercontroller =
        TextEditingController(text: widget.newstudent.phonenumber);
    imageBytes = widget.newstudent.image;
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _agecontroller.dispose();
    _batchcontroller.dispose();
    _numbercontroller.dispose();

    super.dispose();
  }

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
                profileimage(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
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
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (cntxt) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 128, 67, 63),
                              content: const Text(
                                'Do you want to Save edits ?',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      updatestud();
                                      _namecontroller.clear();
                                      _agecontroller.clear();
                                      _batchcontroller.clear();
                                      _numbercontroller.clear();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            );
                          });
                    },
                    label: const Text('Save edits'),
                    icon: const Icon(Icons.edit),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileimage() {
    return Center(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (bldr) => bottomSheet(),
          );
        },
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: _selectImage != null
                  ? FileImage(_selectImage!)
                  : imageBytes != null
                      ? MemoryImage(imageBytes!)
                      : const AssetImage('assets/images/profileimage.jpg'),
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
      // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
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
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnimage != null) {
      setState(() {
        _selectImage = File(returnimage.path);
      });
      Navigator.of(context).pop();
    }
  }

  Future<void> clearProfile() async {
    setState(() {
      widget.newstudent.image = null;
    });
    Navigator.of(context).pop();
  }

  Future<void> updatestud() async {
    final name = _namecontroller.text;
    final age = _agecontroller.text;
    final batch = _batchcontroller.text;
    final number = _numbercontroller.text;

    if (_selectImage != null) {
      imageBytes = await _selectImage!.readAsBytes();
    }

    final newvalues = StudentModel(
      name: name,
      age: age,
      batch: batch,
      phonenumber: number,
      image: imageBytes,
      id: widget.newstudent.id,
    );
    await editStudDetails(newvalues);
  }
}
