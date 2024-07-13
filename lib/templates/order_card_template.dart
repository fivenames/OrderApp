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
    Color cardColor = widget.order.type ? Colors.white70 : Colors.cyan.shade300;

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
                _buildColumnItem('${widget.order.customerTag}', 2, 20.0, Colors.deepOrange.shade900),
                Expanded(
                  flex: 6,
                  child: Wrap(
                    children: widget.order.dishes.map((dish) => _buildDishChip(dish)).toList(),
                  ),
                ),
                _buildColumnItem(widget.order.timeOrdered, 2, 16.0, Colors.blueGrey.shade900),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 70,),
                const Spacer(),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: widget.delete,
                    icon: const Icon(Icons.task, size: 18.0),
                    label: const Text('完成', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                const Spacer(),
                Text("\$${widget.order.sum.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, color: Colors.deepOrange),),
                const SizedBox(width: 30,),
              ]
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

  Widget _buildDishChip(String dish) {
    return Chip(
      label: Text(
        dish,
        style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black),
      ),
      backgroundColor: Colors.lightGreenAccent.shade100,
      labelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}



