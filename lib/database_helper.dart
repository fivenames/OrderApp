import 'dart:collection';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'order_class.dart';

Future<double> queryData(Database database, Map orders) async {
  //query for all incomplete orders
  List<Map> list = await database.rawQuery('SELECT * FROM Orders WHERE status = 0');

  for (var order in list) {
    int id = order['id'];
    List<String> dish = List<String>.from(jsonDecode(order['dishes']));
    String timeOfOrder = order['time'];
    int customerTag = order['customerTag'];
    int types = order['type'];
    bool type = true;
    if(types == 0){
      type = false;
    }
    double sum = order['sum'];

    Order newOrder = Order(customerTag, dish, timeOfOrder, type, sum);
    orders[newOrder] = id;
  }

  List<Map> list2 = await database.rawQuery('SELECT revenue FROM Revenue WHERE id = 1');
  double sum = 0;
  for(var revenue in list2){
    sum = revenue['revenue'];
  }
  return sum;
}

Future<void> insertData(Database database, Order order, double sum, Map orders, double revenue) async {
  await database.transaction((txn) async {
    int customerTag = order.customerTag;
    List<String> dishes = order.dishes;
    String dish = jsonEncode(dishes);
    String time = order.timeOrdered;
    int type = 0;
    if(order.type){
      type = 1;
    }

    int id = await txn.rawInsert(
        'INSERT INTO Orders(customerTag, dishes, time, type, status, sum) VALUES(?, ?, ?, ?, ?, ?)',
        [customerTag, dish, time, type, 0, sum]);

    orders[order] = id;

    await txn.rawUpdate(
      'INSERT OR REPLACE INTO Revenue (id, revenue) VALUES (?, ?)',
      [1, revenue]
    );
  });
}

Future<void> updateData(Database database, int id) async {
  // Update the status column to 1 for the specified id
  await database.rawUpdate(
      'UPDATE Orders SET status = ? WHERE id = ?',
      [1, id]
  );
}

Future<void> clearDatabase(Database database) async {
  await database.delete('Orders');
  await database.delete('Revenue');
  await database.delete('MetaData');
}

Future<void> queryRecord(Database database, List<Order> orders) async {
  //query for all incomplete orders
  List<Map> list = await database.rawQuery('SELECT * FROM Orders ORDER BY time DESC');

  for (var order in list) {
    int id = order['id'];
    List<String> dish = List<String>.from(jsonDecode(order['dishes']));
    String timeOfOrder = order['time'];
    int customerTag = order['customerTag'];
    int types = order['type'];
    bool type = true;
    if(types == 0){
      type = false;
    }
    double sum = order['sum'];

    Order newOrder = Order(customerTag, dish, timeOfOrder, type, sum);
    orders.add(newOrder);
  }
}