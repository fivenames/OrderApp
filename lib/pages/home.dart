import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/order_class.dart';
import 'package:test_app/templates/order_table_header_template.dart';
import 'package:test_app/templates/order_card_template.dart';

import 'dart:core';
import 'package:sqflite/sqflite.dart';


class Home extends StatefulWidget {
  final Database database;
  const Home(this.database, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double revenue = 0.0;
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    queryData(widget.database, orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text(
          '现有订单',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          IconButton( // show daily revenue
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 20,
                      backgroundColor: Colors.black45,
                        content: Text(
                            '今日营业额：\$${revenue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                        )
                    )
                );
              },
              icon: const Icon(Icons.info))
        ],
      ),

      body: Column(
        children: [
          const OrderHeader(),

          Expanded(
            child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index){
              return OrderCard(orders[index], delete: (){
                setState(() {
                  orders.remove(orders[index]);
                });
              });
            },
                    ),
          ),
        ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime now = DateTime.now();
          String currentTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

          showDialog( // Get input for type of order
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("添加订单"),
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context); // pop dialog
                        //
                        dynamic resultList = await Navigator.pushNamed(
                            context, '/add_order',
                            arguments: true, // having here
                        );
                        dynamic dishes = resultList[0];
                        dynamic orderTag = resultList[2];

                        if(dishes.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(orderTag, dishes, currentTime, true);
                            orders.add(newOrder);
                            revenue += resultList[1];
                            insertData(widget.database, newOrder, revenue);
                          });
                        }
                      },

                      child: const Text("吃的")),

                  TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        dynamic resultList = await Navigator.pushNamed(
                            context, '/add_order',
                            arguments: false,
                        );
                        dynamic dishes = resultList[0];
                        dynamic orderTag = resultList[2];

                        if(dishes.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(orderTag, dishes, currentTime, false);
                            orders.add(newOrder);
                            revenue += resultList[1];
                            insertData(widget.database, newOrder, revenue);
                          });
                        }
                      },

                      child: const Text("打包"))
                ],
              ));
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> queryData(Database database, List<Order> orders) async {
  List<Map> list = await database.rawQuery('SELECT * FROM Orders WHERE status = 0');
  for (var order in list) {
    List<String> dish = List<String>.from(jsonDecode(order['dishes']));
    String timeOfOrder = order['time'];
    int customerTag = order['customerTag'];
    int types = order['type'];
    bool type = true;
    if(types == 0){
      type = false;
    }

    Order newOrder = Order(customerTag, dish, timeOfOrder, type);
    orders.add(newOrder);
  }
}

Future<void> insertData(Database database, Order order, double sum) async {
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
  });
}
