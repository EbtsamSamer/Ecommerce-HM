import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeService homeService;

  HomeCubit(this.homeService) : super(HomeInitialState());

  Future<void> loadHomeData() async {
    emit(CategoriesLoadingState());

    try {
      final categories = await homeService.getCategories();

      emit(CategoriesSuccessState(categories));

      if (categories.isNotEmpty && categories.first.id != null) {
        await loadProducts(categories.first.id!);
      } else {
        emit(ProductsSuccessState([]));
      }
    } catch (e) {
      emit(CategoriesErrorState(e.toString()));
    }
  }

  Future<void> loadProducts(int categoryId) async {
    emit(ProductsLoadingState());

    try {
      final products = await homeService.getProducts(categoryId);

      emit(ProductsSuccessState(products));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }
}