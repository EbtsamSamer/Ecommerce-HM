import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_manager.dart';

import '../data/models/category_model.dart';
import '../data/models/product_model.dart';

class HomeService {
  final ApiManager apiManager;

  HomeService(this.apiManager);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiManager.dio.get(
      ApiEndpoints.categoriesEndpoint,
    );

    final List<dynamic> jsonData = response.data as List<dynamic>;

    return jsonData
        .map(
          (item) => CategoryModel.fromJson(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    final response = await apiManager.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$categoryId/'
          '${ApiEndpoints.productsEndpoint}',
    );

    final List<dynamic> jsonData = response.data as List<dynamic>;

    return jsonData
        .map(
          (item) => ProductModel.fromJson(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}