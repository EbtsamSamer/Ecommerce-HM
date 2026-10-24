import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_states.dart';


class HomeCubit extends Cubit<HomeStates> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit({required this.getProductsUseCase,
    required this.getCategoriesUseCase})
      : super(HomeInitialState());

  Future<void> loadHomeData() async {
    int? categoryId=0;
    emit(CategoriesLoadingState());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold((Failure){
      emit(CategoriesErrorState(Failure.errorMessage));
    }, (categories){
      categoryId=categories[0].id;
      emit(CategoriesSuccessState(categories));
    });

    final products = await getProductsUseCase.invoke(categoryId);
   products.fold((Failure){
     emit(ProductsErrorState(Failure.errorMessage));
   }, (products){
  
     emit(ProductsSuccessState(products));
   });

  }

  Future<void> loadProducts(int id) async {
    emit(ProductsLoadingState());
    
      final products = await getProductsUseCase.invoke(id);
    products.fold((Failure){
      emit(ProductsErrorState(Failure.errorMessage));
    }, (products){

      emit(ProductsSuccessState(products));
    });

  }
}
