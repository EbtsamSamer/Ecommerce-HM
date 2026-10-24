import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';

import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

import '../../../../core/network/api_manager.dart';
import '../../../../core/constants/api_endpoints.dart';
import 'home_remote_ds.dart';

class HomeRemoteDsImp implements HomeRemoteDs {
  final ApiManager apiManager;

  HomeRemoteDsImp(this.apiManager);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiManager.dio.get(ApiEndpoints.categoriesEndpoint);

    final List<dynamic> jsonData = response.data as List<dynamic>;

    return jsonData
        .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await apiManager.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$categoryId/'
      '${ApiEndpoints.productsEndpoint}',
    );

    final List<dynamic> jsonData = response.data as List<dynamic>;

    return jsonData
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
