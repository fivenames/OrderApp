import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:test_app/database_helper.dart';
import 'package:test_app/templates/order_record_card_template.dart';
import '../order_class.dart';

class OrderRecord extends StatefulWidget {
  const OrderRecord({super.key});

  @override
  State<OrderRecord> createState() => _OrderRecordState();
}

class _OrderRecordState extends State<OrderRecord> {
  List<Order> orders = [];
  bool isLoading = true;
  Database? database;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // query database here instead of within build, so that database is not queried everytime build is executed.
    if (database == null) {
      database = ModalRoute.of(context)?.settings.arguments as Database?; // context cannot be access at the outers cope
      fetchData();
    }
  }

  void fetchData() async {
    // Ensure database is not null before querying
    if (database != null) {
      await queryRecord(database!, orders);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("订单记录"),
        centerTitle: true,
      ), 
        body: isLoading 
            ? const Center(child: CircularProgressIndicator()) 
            : Column(
            children: [
              Expanded(child: 
              ListView.builder(
                  itemCount:  orders.length,
                  itemBuilder: (context, index){
                return OrderRecordCard(order: orders[index]);
              }))
            ])
    );
    }
}
