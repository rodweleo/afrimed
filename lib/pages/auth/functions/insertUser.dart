import 'package:AfriMed/controllers/database_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertUser(User user) async {
  // Get a reference to the database.
  final db = await DatabaseController().openLocalDatabase();

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'users',
    {
      'id': user.uid.toString()
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}