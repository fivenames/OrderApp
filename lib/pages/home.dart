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
  // Current orders
  List<Order> orders = [];
  double revenue = 0.0;

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
                        Navigator.pop(context);
                        dynamic resultList = await Navigator.pushNamed(
                            context, '/add_order',
                            arguments: true,
                        );
                        dynamic result = resultList[0];

                        if(result.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(1, result, currentTime, true);
                            orders.add(newOrder);
                            revenue += resultList[1];
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
                        dynamic result = resultList[0];

                        if(result.isNotEmpty){
                          setState(() {
                            Order newOrder = Order(1, result, currentTime, false);
                            orders.add(newOrder);
                            revenue += resultList[1];
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