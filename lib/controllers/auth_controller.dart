import 'package:get/get.dart';
import 'package:menus/models/signup_body_model.dart';
import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
