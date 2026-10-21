import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_response_model.dart';

import '../../../../core/network/api_manager.dart';

class SignupService {
  ApiManager apiManager;

  SignupService(this.apiManager);
 Future<SignupResponseModel> signUp(SignupReqModel signupReqModel)async{
    final response =await  apiManager.dio.post(ApiEndpoints.signupEndpoint,data: {
      "email": signupReqModel.email,
      "name": signupReqModel.name,
      "password": signupReqModel.password,
      "avatar": "https://www.nicepng.com/ourpic/u2w7w7o0u2e6e6r5_png-file-woman-person-icon-png/"
    });
    final Map<String,dynamic>jsonData =response.data;
    final modeldata =SignupResponseModel.fromJson(jsonData);
    return modeldata ;
  }
}