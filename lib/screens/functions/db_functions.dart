import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_records/screens/models/student_model.dart';

ValueNotifier<List<StudentModel>> studentlist = ValueNotifier([]);
late Database _db;

Future<void> initializeDb() async {
  _db = await openDatabase(
    'student_db',
    version: 2,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE studentdata (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, batch TEXT, contact INTEGER)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < newVersion) {
        db.execute('ALTER TABLE studentdata ADD COLUMN image BLOB');
      }
    },
  );
}

Future<void> addStudDetails(StudentModel value) async {
  await initializeDb();

  _db.rawInsert(
      'INSERT INTO studentdata(name, age, batch, contact, image) VALUES (?, ?, ?, ?, ?)',
      [value.name, value.age, value.batch, value.phonenumber, value.image]);
  await getStudDetails();
}

Future<void> getStudDetails() async {
  final dbRows = await _db.rawQuery('SELECT * FROM studentdata');
  studentlist.value = dbRows.map((map) => StudentModel.fromMap(map)).toList();
}

Future<void> editStudDetails(StudentModel value) async {
  await _db.rawUpdate(
      'UPDATE studentdata SET name = ?, age = ?, batch = ?, contact = ?, image = ? WHERE id = ?',
      [
        value.name,
        value.age,
        value.batch,
        value.phonenumber,
        value.image,
        value.id
      ]);
  await getStudDetails();
}

Future<void> deleteStudDetails(int id) async {
  await _db.delete('studentdata', where: 'id = ?', whereArgs: [id]);
  await getStudDetails();
}
