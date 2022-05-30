import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menus/controllers/cart_controller.dart';
import 'package:menus/data/repository/popular_product_repo.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({
    required this.popularProductRepo,
  });
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.themeColor1,
        colorText: Colors.white,
      );
      return 0;
    }
    if (quantity > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.themeColor1,
        colorText: Colors.white,
      );
      return 20;
    }
    return quantity;
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
  }
}
