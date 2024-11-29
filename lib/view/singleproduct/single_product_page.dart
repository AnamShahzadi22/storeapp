import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_bloc.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_event.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_state.dart';
import 'package:store_app/bloc/SingleProductBloc/product_detial_bloc.dart';
import 'package:store_app/bloc/SingleProductBloc/product_detial_event.dart';
import 'package:store_app/bloc/SingleProductBloc/product_detial_state.dart';
import 'package:store_app/config/colors/colors.dart';
import 'package:store_app/repository/singelProductRepository/single_product_repository.dart';
import 'package:store_app/view/singleproduct/widget/detail_row_product.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailsBloc>(
          create: (context) =>
              ProductDetailsBloc(repository: SingleProductRepository())
                ..add(FetchProductDetailsEvent(productId: widget.productId)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Product Details",
            style: GoogleFonts.playfairDisplay(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          backgroundColor: whiteColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator(color: blackColor,));
            } else if (state is ProductDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Banner
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.thumbnail!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Details:',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        BlocListener<FavoriteBloc, FavoriteState>(
                          listener: (context, state) {
                            if (state is FavoriteLoaded) {
                              print("New favorites state: ${state.favorites}");
                            }
                          },
                          child: BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, state) {
                              final isFavorite = state is FavoriteLoaded &&
                                  state.favorites.contains(
                                      product); // Check if product is in favorites
                              return GestureDetector(
                                onTap: () {
                                  if (isFavorite) {
                                    context
                                        .read<FavoriteBloc>()
                                        .add(RemoveFromFavoritesEvent(product));
                                  } else {
                                    context
                                        .read<FavoriteBloc>()
                                        .add(AddToFavoritesEvent(product));
                                  }
                                },
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : blackColor,
                                  size: 28,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Product Information
                    DetailRow(label: 'Name', value: product.title),
                    DetailRow(label: 'Price', value: '\$${product.price}'),
                    DetailRow(label: 'Category', value: product.category!),
                    DetailRow(label: 'Brand', value: product.brand!),
                    DetailRow(
                      label: 'Rating',
                      value: product.rating.toString(),
                      trailing:
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              size: 16.0,
                              color: index < (product.rating?.toInt() ?? 0)
                                  ? Colors.amber
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                    DetailRow(label: 'Stock', value: product.stock.toString()),
                    const SizedBox(height: 16),
                    // Description Section
                    Text(
                      'Description:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Product Gallery
                    Text(
                      'Product Gallery:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.images[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
