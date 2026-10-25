import 'package:ecommerce_app_huma_volve/core/error_handling/error.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase {
  final HomeRepo homeRepo;

  GetProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductEntity>>> invoke(int? categoryId,{
    required int limit,
    required int offset,
  }) =>
      homeRepo.getProducts(categoryId, limit: limit, offset: offset);
}
