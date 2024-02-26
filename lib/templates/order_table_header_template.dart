import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '号码',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              '菜品',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '订单时间',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
