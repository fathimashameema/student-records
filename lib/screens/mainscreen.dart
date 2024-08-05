import 'package:flutter/material.dart';
import 'package:student_records/screens/addstudent.dart';
import 'package:student_records/screens/detailedStud.dart';
import 'package:student_records/screens/editdetails.dart';
import 'package:student_records/screens/functions/db_functions.dart';
import 'package:student_records/screens/models/student_model.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  ViewType _viewType = ViewType.list;
  TextEditingController searchword = TextEditingController();
  List<StudentModel> _filteredStudent = [];

  @override
  void initState() {
    super.initState();
    searchword.addListener(_filterStudents);
    getStudDetails();
  }

  @override
  void dispose() {
    searchword.removeListener(_filterStudents);
    searchword.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final query = searchword.text.toLowerCase();
    setState(() {
      _filteredStudent = studentlist.value
          .where((student) => student.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 128, 67, 63),
          title: const Text(
            'Student Data',
            style: TextStyle(
              color: Color.fromARGB(255, 185, 185, 185),
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const AddStud();
                }));
              },
              icon: const Icon(Icons.add),
              iconSize: 30,
              splashRadius: 25,
              splashColor: const Color.fromARGB(255, 128, 81, 81),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () {
                gridview();
              },
              icon: _viewType == ViewType.list
                  ? const Icon(Icons.grid_on)
                  : const Icon(Icons.list),
              iconSize: 25,
              splashRadius: 25,
              splashColor: const Color.fromARGB(255, 128, 81, 81),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: TextFormField(
                controller: searchword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Search....',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<StudentModel>>(
                valueListenable: studentlist,
                builder: (context, student, child) {
                  if (searchword.text.isEmpty) {
                    _filteredStudent = student;
                  }
                  if (_filteredStudent.isEmpty) {
                    return const Center(
                      child: Text('No items found'),
                    );
                  }
                  return _viewType == ViewType.list
                      ? listscreen(_filteredStudent)
                      : gridscreen(_filteredStudent);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gridview() async {
    setState(() {
      _viewType = _viewType == ViewType.list ? ViewType.grid : ViewType.list;
    });
  }

  Widget listscreen(List<StudentModel> students) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final data = students[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: data.image != null
                ? MemoryImage(data.image!)
                : const AssetImage('assets/images/profileimage.jpg'),
          ),
          title: Text(data.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (cntxt1) {
                      return EditStudent(newstudent: data);
                    }),
                  );
                },
                icon: const Icon(Icons.edit),
                iconSize: 18,
                splashRadius: 20,
                splashColor: const Color.fromARGB(255, 244, 239, 239),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor:
                              const Color.fromARGB(255, 128, 67, 63),
                          title: const Text(
                            'Delete student ?',
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                )),
                            TextButton(
                                onPressed: () {
                                  deleteStudDetails(data.id!);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete),
                iconSize: 18,
                splashRadius: 20,
                splashColor: const Color.fromARGB(255, 244, 239, 239),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx1) {
                  return DetailedStud(student: data);
                },
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: students.length,
    );
  }

  Widget gridscreen(List<StudentModel> students) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final data = students[index];
        return GestureDetector(
          child: GridTile(
            header: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (cntxt1) {
                            return EditStudent(newstudent: data);
                          }),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      iconSize: 18,
                      color: const Color.fromARGB(255, 222, 221, 221),
                    ),
                    const SizedBox(
                      width: 98,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                backgroundColor:
                                    const Color.fromARGB(255, 128, 67, 63),
                                title: const Text(
                                  'Delete student ?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        deleteStudDetails(data.id!);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.delete),
                      iconSize: 18,
                      color: const Color.fromARGB(255, 222, 221, 221),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: data.image != null
                      ? MemoryImage(data.image!)
                      : const AssetImage('assets/images/profileimage.jpg'),
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  data.name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 222, 221, 221), fontSize: 20),
                ),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 128, 81, 81),
              ),
              height: 50,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx1) {
                  return DetailedStud(student: data);
                },
              ),
            );
          },
        );
      },
      itemCount: students.length,
    );
  }
}

enum ViewType { grid, list }
