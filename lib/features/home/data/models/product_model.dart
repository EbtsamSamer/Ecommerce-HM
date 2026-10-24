
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

import 'category_model.dart';

class ProductModel extends ProductEntity{

  ProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.categoryEntity,
    super.images = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: json['price'],
      description: json['description'],
      categoryEntity: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
    );
  }
}