import 'category_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  num? price;
  String? description;
  CategoryModel? categoryModel;
  List<String> images;
  String? creationAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.categoryModel,
    this.images = const [],
    this.creationAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final imagesData = json['images'];

    return ProductModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      price: json['price'] as num?,
      description: json['description'] as String?,
      categoryModel: json['category'] is Map<String, dynamic>
          ? CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      )
          : null,
      images: imagesData is List
          ? imagesData.whereType<String>().toList()
          : [],
      creationAt: json['creationAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}