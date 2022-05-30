import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:menus/utils/app_constants.dart';
import '../api/api_client.dart';

class PromotionProductRepo extends GetxService {
  final ApiClient apiClient;
  PromotionProductRepo({required this.apiClient});

  Future<Response> getPromotionProductList() async {
    return await apiClient.getData(AppConstants.PROMOTION_PRODUCTS_URI);
  }
}
