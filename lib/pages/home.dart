import 'package:flutter/material.dart';
import 'package:test_app/order_class.dart';
import 'package:test_app/templates/order_table_header_template.dart';
import 'package:test_app/templates/order_card_template.dart';

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
        onPressed: () async {
           dynamic result = await Navigator.pushNamed(context, '/add_order');
           if(result) {
             setState(() {
               Order newOrder = Order(1, result, '1900');
               orders.add(newOrder);
             });
           }
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}