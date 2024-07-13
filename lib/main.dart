import 'package:flutter/material.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/add_order_first.dart';
import 'package:test_app/pages/big_order.dart';
import 'package:test_app/pages/small_order.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get a location using getDatabasesPath
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, 'orders.db');

  //await deleteDatabase(path); //for testing purposes

  // Get current date
  DateTime now = DateTime.now();
  String date = join(now.day.toString(), now.month.toString(), now.year.toString());

  // Open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // Create table to store orders
        await db.execute(
          // dishes is a list of strings JSON encoded text
          // type: 1 for having here, 0 for take away
          // status: 1 for completed orders, 0 for uncompleted orders
            'CREATE TABLE Orders (id INTEGER PRIMARY KEY, customerTag INTEGER, dishes TEXT, time TEXT, type INTEGER, status INTEGER, sum REAL)'
        );

        // Create table to store revenue
        await db.execute(
            'CREATE TABLE Revenue (id INTEGER PRIMARY KEY, revenue REAL)'
        );

        // Create table to check last cleared database; current version, clears each new day
        await db.execute(
            'CREATE TABLE MetaData (id INTEGER PRIMARY KEY, databaseLastCleared TEXT)'
        );
        await db.execute('INSERT INTO MetaData (id, databaseLastCleared) VALUES (1, "$date")');
      });

  List<Map> list = await database.rawQuery('SELECT databaseLastCleared FROM MetaData WHERE id = 1');
  String lastCleared = '';
  for(var data in list){
    lastCleared = data['databaseLastCleared'];
  }

  if(lastCleared != date){
    await clearDatabase(database);
    await database.execute('INSERT INTO MetaData (id, databaseLastCleared) VALUES (1, "$date")');
  }

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
