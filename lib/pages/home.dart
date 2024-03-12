import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:test_app/order_class.dart';
import 'package:test_app/templates/order_table_header_template.dart';
import 'package:test_app/templates/order_card_template.dart';
import 'dart:core';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '现有订单',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: [
          // header row
          const OrderHeader(),
          // Order rows
          ...orders.map((order) => OrderCard(
            order,
            delete: () {
              setState(() {
                orders.remove(order);
              });
            },
          )).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime now = DateTime.now();
          String currentTime = '${now.hour}:${now.minute}';

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("添加订单"),
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        dynamic result = await Navigator.pushNamed(context, '/add_order');
                        if(result.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(1, result, currentTime, true);
                            orders.add(newOrder);
                          });
                        }
                      },
                      child: const Text("吃的")),
                  TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        dynamic result = await Navigator.pushNamed(context, '/add_order');
                        if(result.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(1, result, currentTime, false);
                            orders.add(newOrder);
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