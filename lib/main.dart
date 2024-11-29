import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_bloc.dart';
import 'package:store_app/repository/CategoryRepository/category_repository.dart';
import 'package:store_app/repository/productRepository/product_repository.dart';
import 'package:store_app/repository/singelProductRepository/single_product_repository.dart';
import 'package:store_app/view/splash/splash_screeen.dart';

GetIt getIt = GetIt.instance;

void main() {
  servicesLocator();
  runApp(BlocProvider(
    create: (context) => FavoriteBloc(),
    child: MyApp(),
  ));
}


void servicesLocator() {
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository());
  getIt.registerLazySingleton<SingleProductRepository>(() => SingleProductRepository());
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),

    );
  }

}
