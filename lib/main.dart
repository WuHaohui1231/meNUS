import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menus/controllers/popular_product_controller.dart';
import 'package:menus/controllers/promotion_product_controller.dart';
import 'package:menus/pages/food/promotion_food_detail.dart';
import 'package:menus/pages/home/food_page_body.dart';
import 'package:menus/pages/home/main_food_page.dart';
import 'package:menus/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<PromotionProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
