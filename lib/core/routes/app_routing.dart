import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/domain/entities/product_entity.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/products/:id",
      builder: (context, state) {
        final productEntity = state.extra as ProductEntity?;

        final productId = int.tryParse(state.pathParameters['id'] ?? '');

        return ProductDetailsScreen(
          productEntity: productEntity,
          productId: productId,
        );
      },
    ),
  ],
);
