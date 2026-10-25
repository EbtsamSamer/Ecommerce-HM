import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final int limit = 10;
  int offset = 0;
  int? selestedCategory;
  bool loadMore = false;
  bool hasMore = true;

  final List<ProductEntity> _products = [];

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitialState());

  Future<void> loadHomeData() async {
    int? categoryId = 0;
    emit(CategoriesLoadingState());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
          (Failure) {
        emit(CategoriesErrorState(Failure.errorMessage));
      },
          (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccessState(categories));
      },
    );

    final products = await getProductsUseCase.invoke(
      categoryId,
      limit: limit,
      offset: offset,
    );
    products.fold(
          (Failure) {
        emit(ProductsErrorState(Failure.errorMessage));
      },
          (products) {
        emit(ProductsSuccessState(products));
      },
    );
  }

  Future<void> loadProducts(int id) async {
    hasMore = true;
    _products.clear();
    emit(ProductsLoadingState());

    final products = await getProductsUseCase.invoke(
      id,
      limit: limit,
      offset: offset,
    );
    products.fold(
          (Failure) {
        emit(ProductsErrorState(Failure.errorMessage));
      },
          (products) {
        _products.addAll(products);
        offset = products.length;
        if (products.length < limit) {
          hasMore = false;
        }
        selestedCategory = id;
        emit(ProductsSuccessState(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (loadMore || !hasMore) return;
    loadMore = true;
    emit(LOadMoreProductsLoadingState());
    final result = await getProductsUseCase.invoke(
        selestedCategory, limit: limit, offset: offset);
    result.fold((failure){
      emit(LOadMoreProductsErrorState(failure.errorMessage));

    }, (newProducts){

_products.addAll(newProducts);
offset+=newProducts.length;
if (newProducts.length < limit) {
  hasMore = false;
}
emit(ProductsSuccessState(_products));
    }
    );

  }
}
