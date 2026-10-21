import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_manager.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response_model.dart';

class LoginService {
  ApiManager apiManager;

  LoginService(this.apiManager);

  login({required String email, required String password}) async {
    final response = await apiManager.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {"email": email, "password": password},
    );
    final Map<String,dynamic> jsondata =response.data;
    final modeldata =LoginResponseModel.fromJson(jsondata);
    return modeldata;
  }

}
