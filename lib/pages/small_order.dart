import 'package:flutter/material.dart';
import 'package:test_app/menu_class.dart';
import 'package:test_app/templates/menu_card_template.dart';

class SmallOrder extends StatefulWidget {
  const SmallOrder({super.key});

  @override
  State<SmallOrder> createState() => _BigOrderState();
}

class _BigOrderState extends State<SmallOrder> {
  List<String> orders = [];
  List<String> menuList = Menu.getSmallMenu();
  late List<int> counts;

  @override
  Widget build(BuildContext context) {
    int len = menuList.length;
    counts = List.filled(len, 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('添加订单'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: len,
        itemBuilder: (context, index) {
          return MenuCard(menuItem: menuList[index], order: orders, counts: counts, index: index,);
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