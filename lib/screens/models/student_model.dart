import 'dart:typed_data';

class StudentModel {
  final String name;
  final String age;
  final String batch;
  final String phonenumber;
  int? id;
  Uint8List? image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.batch,
      required this.phonenumber,
      this.id,
      this.image});

  // static StudentModel convertmap(Map<String, Object?> map) {
  //   final name = map['name'] as String;
  //   final age = map['age'] as String;
  //   final batch = map['batch'] as String;
  //   final phonenumber = map['number'] as String;
  //   final id = map['id'] as int;

  static StudentModel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    final age = map['age']?.toString() ?? '';
    final batch = map['batch'] as String;
    final phonenumber = map['contact']?.toString() ?? '';
    final id = map['id'] as int?;
    var image = map['image'] != null ? map['image'] as Uint8List : null;

    return StudentModel(
        id: id,
        name: name,
        age: age,
        batch: batch,
        phonenumber: phonenumber,
        image: image);
  }
}
