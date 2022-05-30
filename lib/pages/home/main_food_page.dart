import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menus/controllers/popular_product_controller.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/big_text.dart';
import 'package:menus/widgets/small_text.dart';
import '../../utils/dimensions.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageStatus();
}

class _MainFoodPageStatus extends State<MainFoodPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: AppBar(
              backgroundColor: AppColors.themeColor1,
              flexibleSpace: Container(
                color: AppColors.themeColor1,
                margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BigText(
                          text: "NUS Canteens",
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Select",
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.arrow_drop_down_circle_rounded,
                              color: AppColors.themeColor2,
                              size: Dimensions.iconSize24,
                            )
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height30),
          Expanded(
            child: SingleChildScrollView(child: FoodPageBody()),
          ),
        ],
      ),
    );
  }
}
