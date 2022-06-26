import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:menus/utils/colors.dart';
import './orders_page.dart';
import './menu_page.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  int currIndex = 0;
  final screens = [
    OrdersPage(),
    VendorMenuPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('meNUS'),
        centerTitle: true,
        backgroundColor: AppColors.themeColor1,
      ),
      body: screens[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currIndex,
        onTap: (index) => setState(() {
          currIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
            backgroundColor: AppColors.themeColor1,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
            backgroundColor: AppColors.themeColor2,
          ),
        ],
      ),
    );
  }
}