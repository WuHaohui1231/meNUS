import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class VendorMenuPage extends StatefulWidget {
  const VendorMenuPage({Key? key}) : super(key: key);

  @override
  State<VendorMenuPage> createState() => _VendorMenuPageState();
}

class _VendorMenuPageState extends State<VendorMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Beef Noodle"),
        Text("Fishball Noodle"),
        Text("卤蛋")
      ],
    );
  }
}