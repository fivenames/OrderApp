import 'package:flutter/material.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/add_order_first.dart';
import 'package:test_app/pages/big_order.dart';
import 'package:test_app/pages/small_order.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get a location using getDatabasesPath
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'orders.db');

  // Open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          // dishes is a list of strings JSON encoded text
          // type: 1 for having here, 0 for take away
          // status: 1 for completed orders, 0 for uncompleted orders
            'CREATE TABLE Orders (id INTEGER PRIMARY KEY, customerTag INTEGER, dishes TEXT, time TEXT, type INTEGER, status INTEGER, sum REAL)');
      });

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Home(database),
        '/add_order': (context) => const AddOrder(),
        '/small_order': (context) => const SmallOrder(),
        '/big_order': (context) => const BigOrder(),
      },
    );
  }
}
