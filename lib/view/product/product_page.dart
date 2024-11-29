import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/bloc/ProductBloc/product_bloc.dart';
import 'package:store_app/bloc/ProductBloc/product_event.dart';
import 'package:store_app/bloc/ProductBloc/product_state.dart';
import 'package:store_app/config/colors/colors.dart';
import 'package:store_app/main.dart';
import 'package:store_app/utills/enum.dart';
import 'package:store_app/view/product/widget/product_card.dart';
import 'package:store_app/view/singleproduct/single_product_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(productRepository: getIt());
    _productBloc.add(FetchProductsEvent());
  }

  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Products",
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
      body: BlocProvider(
        create: (_) => _productBloc..add(FetchProductsEvent()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, state) {
            // Handle products state
            final isCompleted = state.productsResponse.status == Status.COMPLETED;
            final isError = state.productsResponse.status == Status.ERROR;
            final products = isCompleted ? (state.productsResponse.data ?? []) : [];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      cursorColor: blackColor,
                      style: GoogleFonts.poppins(
                        color: blackColor, // Set the text color
                        fontSize: 16.0,    // Adjust font size
                        fontWeight: FontWeight.w400, // Adjust font weight
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: greyColor),
                        hintText: 'Search products',
                        hintStyle: GoogleFonts.poppins(color: greyColor),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: blackColor, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: blackColor, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: blackColor, width: 1.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        context.read<ProductBloc>().add(SearchProductsEvent(query: value));
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Display message or number of results
                  if (isCompleted && products.isEmpty)
                    Text(
                      "No results found",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    )
                  else if (isCompleted)
                    Text(
                      "${products.length} results found",
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.0),
                    ),
                  const SizedBox(height: 10.0),

                  // Product List or Error Message
                  if (isError)
                    Expanded(
                      child: Center(
                        child: Text(
                          "Error: ${state.productsResponse.message ?? 'Something went wrong'}",
                          style: GoogleFonts.poppins(color: Colors.red),
                        ),
                      ),
                    )
                  else if (isCompleted && products.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No products match your search.",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                    )
                  else if (isCompleted)
                      Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(productId: product.id),
                                  ),
                                );
                              },
                              child: ProductCard(products: product),
                            );
                          },
                        ),
                      )
                    else
                    // Loading State
                      const Expanded(
                        child: Center(child: CircularProgressIndicator(color: blackColor,)),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
