import 'package:flutter/material.dart';
import 'package:test_app/menu_class.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  List<String> dishes = [];
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    bool orderType = ModalRoute.of(context)?.settings.arguments as bool;

    return Scaffold(
      appBar: AppBar(
        title: const Text('添加订单'),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '已点：',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    const SizedBox(width: 33,),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            dishes.isEmpty ? '无' : dishes.join(', '),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 33,),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dishes = [];
                            sum = 0;
                          });
                        },
                        child: const Icon(Icons.delete
                        ))
                  ],
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_money_rounded,
                      size: 36,
                      color: Colors.amber.shade200,
                      weight: 20,
                    ),
                    Text(
                      sum.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent.shade200,
                      ),
                    ),
                    const SizedBox(width: 18,),
                  ],
                ),
              )
          ),

          Expanded(
            flex: 5,
            child: Card(
              color: Colors.orangeAccent.shade100,
              child: ListTile(
                onTap: () async {
                  dynamic result = await Navigator.pushNamed(context, '/big_order');
                  setState(() {
                    dishes = dishes + result;
                    sum += calculateSum(result, orderType, true);
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
            flex: 5,
            child: Card(
              color: Colors.lightBlueAccent.shade100,
              child: ListTile(
                onTap: () async {
                  dynamic result = await Navigator.pushNamed(context, '/small_order');
                  setState(() {
                    dishes = dishes + result;
                    sum += calculateSum(result, orderType, false);
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
          if(dishes.isNotEmpty){
          showDialog<int>(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text("号码"),
              children: List.generate(10, (tag) {
                tag += 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context); // pop dialog

                      List<dynamic> data = [dishes, sum, tag];
                      Navigator.pop(context, data); // pop page
                    },
                    child: Text(tag.toString(), style: const TextStyle(fontSize: 18),),
                  ),
                );
              }),
            ),
          );}
          else{
            Navigator.pop(context, [[], 0, 0]);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }


  double calculateSum(List<String> dishes, bool orderType, bool menuType){
    double orderSum = 0;

    for(final dish in dishes){
      if(menuType) {
        orderSum += Menu.getBigMenuPrice(dish)!;
      }
      else{
        orderSum += Menu.getSmallMenuPrice(dish)!;
      }

      if(!orderType){
        if(dish == '饭' || dish == '蛋'){
          continue;
        }
        else if(Menu.isBigBox(dish)){
          orderSum += 1;
        }
        else{
          orderSum += 0.3;
        }
      }
    }
    return orderSum;
  }
}
