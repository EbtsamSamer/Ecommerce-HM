import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class ProductEntity {
  int? id;
  String? title;
  String? slug;
  num? price;
  String? description;
  CategoryEntity? categoryEntity;
  List<String> images;

  ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.categoryEntity,
    this.images = const [],
  });
}
