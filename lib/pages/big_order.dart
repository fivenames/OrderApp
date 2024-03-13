import 'package:flutter/material.dart';
import 'package:test_app/menu_class.dart';
import 'package:test_app/templates/menu_card_template.dart';

class BigOrder extends StatefulWidget {
  const BigOrder({super.key});

  @override
  State<BigOrder> createState() => _BigOrderState();
}

class _BigOrderState extends State<BigOrder> {
  List<String> orders = [];
  List<String> menuList = Menu.getBigMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加订单'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return MenuCard(menuItem: menuList[index], count: 0, order: orders,);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context, orders);
      },
        child: const Icon(Icons.check),
      ),
    );
  }
}
