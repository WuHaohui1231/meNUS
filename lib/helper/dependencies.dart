import 'package:get/get.dart';
import 'package:menus/controllers/recommended_product_controller.dart';

import '../controllers/popular_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
