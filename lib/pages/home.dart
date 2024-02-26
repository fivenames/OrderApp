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
  List<Order> orders = [
    Order(1, ['7', '2', '14', '24', '1*'], '1900'),
    Order(7, ['32B'], '1903'),
    Order(7, ['32B'], '1903'),
    Order(1, ['7', '2', '14', '24', '1*'], '1900'),
    Order(7, ['32B'], '1903'),
    Order(7, ['32B'], '1903'),
    Order(1, ['7', '2', '14', '24', '1*', '7', '2', '14', '24', '1*'], '1900'), // TODO: consider for cases when order is too long
    Order(7, ['32B'], '1903'),
  ];

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
          Navigator.pushNamed(context, '/add_order');
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}