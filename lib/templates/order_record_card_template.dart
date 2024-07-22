import 'package:flutter/material.dart';
import '../order_class.dart';

class OrderRecordCard extends StatelessWidget {
  const OrderRecordCard({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text('号码: ${order.customerTag}', style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),
            Text('点菜: ${order.dishes.join(', ')}', style: const TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            Text('时间: ${order.timeOrdered}', style: const TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            Text('类型: ${order.type == true ? '吃的' : '打包'}', style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),
            Text('价格: \$${order.sum.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
