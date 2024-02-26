import 'package:flutter/material.dart';
import '../order_class.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final void Function() delete;

  const OrderCard(this.order, {Key? key, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildColumnItem('${order.customerTag}', 2, 20.0, Colors.redAccent),
                _buildColumnItem(
                  order.dishes.join(', '), 6, 18.0, Colors.green,
                ),
                _buildColumnItem(order.timeOrdered, 2, 16.0, Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: delete,
                icon: const Icon(Icons.task, size: 20.0),
                label: const Text('完成', style: TextStyle(fontSize: 12.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnItem(String text, int flex, double fontSize, Color color) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: color),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

