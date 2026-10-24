import 'package:ecommerce_app_huma_volve/core/error_handling/error.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase {
  final HomeRepo homeRepo;

  GetCategoriesUseCase(this.homeRepo);

  Future<Either<Failure, List<CategoryEntity>>> invoke() =>
      homeRepo.getCategories();
}
