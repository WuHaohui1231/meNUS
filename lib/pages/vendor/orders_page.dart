import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../widgets/app_text_field.dart';
import './Order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  //var orders = [Text("Order 1 from Ben"), Text("Order 2"), Text("金汤肥牛两份")];

  void handleComplete(int id) {
    for (var o in orders) {
      if (o.id == id) {
        setState(() {
          orders.remove(o);
          orders = orders;
        });
        return;
      }
    }
    return;
  }

  

  List<Order> orders = [
      Order(id: 1, items: ['Steak', 'Pasta'], total_price: 0, customer: 'Kevin', time: '11:50',),
      Order(id: 2, items: ['Steak', 'Pasta'], total_price: 0, customer: 'Bob', time: '11:55'),
      Order(id: 3, items: ['Steak', 'Pasta'], total_price: 0, customer: 'Jane', time: '12:00'),
      
    ];

  @override
  Widget build(BuildContext context) {
    return Column(children: orders);

    // return MaterialApp(
    //   title: title,
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(

    //     body: ListView.builder(
    //       // Let the ListView know how many items it needs to build.
    //       itemCount: items.length,
    //       // Provide a builder function. This is where the magic happens.
    //       // Convert each item into a widget based on the type of item it is.
    //       //physics: ScrollPhysics(),
    //       itemBuilder: (context, index) {
    //         final item = items[index];

    //         return ListTile(
    //           title: item.buildTitle(context),
    //           subtitle: item.buildSubtitle(context),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

