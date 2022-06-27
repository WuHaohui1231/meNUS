import 'dart:ffi';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:menus/utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/icon_and_text_widget.dart';

class Order extends StatelessWidget {
  int id;
  List<String> items;
  double total_price;
  String customer;
  String time;

  Order(
      {Key? key,
      required this.id,
      required this.items,
      required this.total_price,
      required this.customer,
      required this.time,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconAndTextWidget(icon: Icons.person, text: this.customer, iconColor: AppColors.titleColor),
                  IconAndTextWidget(icon: Icons.access_time_filled, text: this.time, iconColor: Colors.redAccent),
                  ...items
                      .map((it) => Text(
                            it,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, color: AppColors.titleColor),
                          ))
                      .toList(),
                ],
              )),
          Expanded(
            flex: 4,
            child: Material(
              color: Colors.amber,
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: Dimensions.screenWidth * 0.2,
                onPressed: () {
                  return ;
                },
                child: Text("Complete",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
