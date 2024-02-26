import 'package:flutter/material.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  List<String> dishes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('添加订单'),
          centerTitle: true,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '已点',
                      style: TextStyle(fontSize: 18,),),
                    Text(
                      dishes.isEmpty ? '无' : dishes.join(', '),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dishes = [];
                          });
                        },
                        child: const Icon(Icons.delete
                        ))
                  ],
                ),
              )
          ),
          Expanded(
            flex: 4,
            child: Card(
              color: Colors.orangeAccent,
              child: ListTile(
                onTap: () async {
                  dynamic result = await Navigator.pushNamed(context, '/big_order');
                  setState(() {
                    dishes = dishes + result;
                  });
                },
                title: const Text(
                  '菜',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Card(
              color: Colors.lightBlueAccent,
              child: ListTile(
                onTap: () async {
                  dynamic result = Navigator.pushNamed(context, '/small_order');
                  setState(() {
                    dishes = dishes + result;
                  });
                },
                title: const Text(
                  '盖饭/面',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
