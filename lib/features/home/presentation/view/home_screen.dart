import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dummy_data.dart';
import '../../../../core/theme.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHomeData();
  }

  Product convertToProduct(ProductModel product) {
    return Product(
      id: product.id?.toString() ?? '',
      name: product.title ?? 'Unknown Product',
      description: product.description ?? '',
      price: product.price?.toDouble() ?? 0.0,
      imageUrl: product.images.isNotEmpty
          ? product.images.first
          : 'https://placehold.co/300x300',
      colors: [Colors.white, Colors.black, Colors.grey],
      sizes: ['S', 'M', 'L', 'XL'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: AppTheme.primary,
                          ),
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            dummyUser.profilePictureUrl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Explore',
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Best trendy collection!',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search clothes...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Categories from API
                    BlocBuilder<HomeCubit, HomeStates>(
                      buildWhen: (previous, current) {
                        return current is CategoriesLoadingState ||
                            current is CategoriesSuccessState ||
                            current is CategoriesErrorState;
                      },
                      builder: (context, state) {
                        if (state is CategoriesLoadingState ||
                            state is HomeInitialState) {
                          return const SizedBox(
                            height: 44,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (state is CategoriesErrorState) {
                          return SizedBox(
                            height: 44,
                            child: Center(
                              child: Text(
                                'Failed to load categories: '
                                '${state.errorMessage}',
                              ),
                            ),
                          );
                        }

                        if (state is CategoriesSuccessState) {
                          final categories = state.categories;

                          if (categories.isEmpty) {
                            return const SizedBox(
                              height: 44,
                              child: Center(
                                child: Text('No categories found.'),
                              ),
                            );
                          }

                          return SizedBox(
                            height: 44,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return CategoryChip(
                                  label: categories[index].name ?? '',
                                  isSelected: _selectedCategoryIndex == index,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });

                                    final categoryId = categories[index].id;

                                    if (categoryId != null) {
                                      context.read<HomeCubit>().loadProducts(
                                        categoryId,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }

                        return const SizedBox(height: 44);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Products from the selected category
            BlocBuilder<HomeCubit, HomeStates>(
              buildWhen: (previous, current) {
                return current is ProductsLoadingState ||
                    current is ProductsSuccessState ||
                    current is ProductsErrorState;
              },
              builder: (context, state) {
                if (state is ProductsLoadingState ||
                    state is HomeInitialState) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                if (state is ProductsErrorState) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'Failed to load products.\n'
                          '${state.errorMessage}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }

                if (state is ProductsSuccessState) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: Text('No products found in this category.'),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ProductCard(
                          productEntity: products[index],
                        );
                      }, childCount: products.length),
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
