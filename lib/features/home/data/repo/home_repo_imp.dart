import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error_handler.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_ds.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final HomeRemoteDs homeRemoteDs;

  HomeRepoImp(this.homeRemoteDs);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDs.getCategories();

      return Right(categories as List<CategoryEntity>);
    } catch (e) {
      final error = ErrorHandler.handle(e);

      return Left(Failure(errorMessage: error.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    int? categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final products = await homeRemoteDs.getProducts(
        categoryId,
        limit: limit,
        offset: offset,
      );

      return Right(products as List<ProductEntity>);
    } catch (e) {
      final error = ErrorHandler.handle(e);

      return Left(Failure(errorMessage: error.message));
    }
  }
}
