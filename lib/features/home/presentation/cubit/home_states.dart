import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

abstract class HomeStates {}
class HomeInitialState extends HomeStates{}

class CategoriesLoadingState extends HomeStates{}

class CategoriesSuccessState extends HomeStates{
  final List<CategoryModel>categories;
  CategoriesSuccessState(this.categories);
}

class CategoriesErrorState extends HomeStates{
  final String errorMessage;
  CategoriesErrorState(this.errorMessage);
}

class ProductsLoadingState extends HomeStates{}

class ProductsSuccessState extends HomeStates{
  final List<ProductModel> products;
  ProductsSuccessState(this.products);
}

class ProductsErrorState extends HomeStates{
  final String errorMessage;
  ProductsErrorState(this.errorMessage);
}