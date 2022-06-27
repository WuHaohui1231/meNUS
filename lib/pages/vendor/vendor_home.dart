import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:menus/utils/colors.dart';
import './orders_page.dart';
import './menu_page.dart';
import './vendor_profile.dart';
import '../../utils/dimensions.dart';
import './info_page.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  int currIndex = 0;
  final screens = [
    OrdersPage(),
    VendorMenuPage(),
    ProfilePage()
  ];

  String title = 'Your Stall';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(child: Text(title)),
            Container(
              width: Dimensions.width45,
              height: Dimensions.height45,
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.white,
                size: Dimensions.iconSize24,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.radius15),
              ),
            ),
          ],
        ),
        // flexibleSpace: Row(
        //   children: [
        //     Text(title),
        //     Container(
        //                 width: Dimensions.width45,
        //                 height: Dimensions.height45,
        //                 child: Icon(
        //                   Icons.search,
        //                   color: Colors.white,
        //                   size: Dimensions.iconSize24,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   borderRadius:
        //                       BorderRadius.circular(Dimensions.radius15),
        //                 ),
        //               ),
        //   ],
        // ),
        centerTitle: false,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Profile',
            backgroundColor: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }
}