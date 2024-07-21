import 'package:flutter/material.dart';

class OrderRecord extends StatelessWidget {
  const OrderRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("订单记录"),
        centerTitle: true,
      ),
    );
  }
}
