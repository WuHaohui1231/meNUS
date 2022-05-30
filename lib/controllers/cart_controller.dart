import 'package:get/get.dart';
import 'package:menus/data/repository/cart_repo.dart';
import 'package:menus/models/products_model.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  void addItem(ProductModel product, int quantity) {
    _items.putIfAbsent(
      product.id!,
      () => CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        ifExist: true,
        time: DateTime.now().toString(),
      ),
    );
  }
}
