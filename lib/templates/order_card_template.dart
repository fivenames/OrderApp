import 'package:flutter/material.dart';
import '../order_class.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  final void Function() delete;

  const OrderCard(this.order, {Key? key, required this.delete}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    Color cardColor = widget.order.type ? Colors.white : Colors.lightBlueAccent.shade100;

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildColumnItem('${widget.order.customerTag}', 2, 20.0, Colors.redAccent),
                _buildColumnItem(
                  widget.order.dishes.join(', '), 6, 18.0, Colors.black,
                ),
                _buildColumnItem(widget.order.timeOrdered, 2, 16.0, Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: widget.delete,
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


