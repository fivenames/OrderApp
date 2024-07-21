import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({super.key, required this.menuItem, required this.order, required this.counts, required this.index});
  final String menuItem;
  final List<String> order;
  final List<int> counts;
  final int index;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(6),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.menuItem,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (widget.counts[widget.index] > 0) {
                      widget.order.remove(widget.menuItem);
                      setState(() {
                        widget.counts[widget.index]--;
                      });
                    }
                  },
                ),
                Text(
                  '${widget.counts[widget.index]}',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.order.add(widget.menuItem);
                    setState(() {
                      widget.counts[widget.index]++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
