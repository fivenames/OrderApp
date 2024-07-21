import 'package:flutter/material.dart';
import 'package:test_app/order_class.dart';
import 'package:test_app/templates/order_table_header_template.dart';
import 'package:test_app/templates/order_card_template.dart';

import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/database_helper.dart';


class Home extends StatefulWidget {
  final Database database;
  const Home(this.database, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double revenue = 0.0;
  Map<Order, int> orders = {}; // Order : table ID of database
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // called once during boot up
    revenue = await queryData(widget.database, orders);
    setState(() {
      isLoading = false;
    });
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
            color: Colors.white54,
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
              icon: const Icon(Icons.info)),
          PopupMenuButton(
            iconColor: Colors.white70,
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: 'record',
                  child: Text("订单记录"),)
            ],
            onSelected: (value) {
            if(value == 'record'){
              Navigator.pushNamed(context, '/record');
            }
          },),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const OrderHeader(),

          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                List<MapEntry<Order, int>> orderEntries = orders.entries.toList();
                Order currentOrder = orderEntries[index].key;
                int id = orderEntries[index].value;
                return OrderCard(currentOrder, delete: () {
                  setState(() {
                    orders.remove(currentOrder);
                    updateData(widget.database, id);
                  });
                });
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                        dynamic sum = resultList[1];
                        dynamic orderTag = resultList[2];

                        if(dishes.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(orderTag, dishes, resultList[3], true, sum);
                            orders[newOrder] = -1;
                            revenue += sum;
                            insertData(widget.database, newOrder, sum, orders, revenue);
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
                        dynamic sum = resultList[1];
                        dynamic orderTag = resultList[2];

                        if(dishes.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(orderTag, dishes, resultList[3], false, sum);
                            orders[newOrder] = -1;
                            revenue += sum;
                            insertData(widget.database, newOrder, sum, orders, revenue);
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


