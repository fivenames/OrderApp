import 'package:flutter/material.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/add_order_first.dart';
import 'package:test_app/pages/big_order.dart';
import 'package:test_app/pages/small_order.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Home(),
      '/add_order': (context) => const AddOrder(),
      '/small_order': (context) => const SmallOrder(),
      '/big_order': (context) => const BigOrder(),
    },
  ));
}
