import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  MenuCard({super.key, required this.menuItem, required this.count, required this.order});
  final String menuItem;
  final int count;
  List<String> order;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int count = 0;
  late List<String> order;

  @override
  void initState() {
    super.initState();
    count = widget.count;
    order = widget.order;
  }

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
                    if (count > 0) {
                      order.remove(widget.menuItem);
                      setState(() {
                        count--;
                      });
                    }
                  },
                ),
                Text(
                  '$count',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    order.add(widget.menuItem);
                    setState(() {
                      count++;
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
