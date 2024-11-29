import 'package:flutter/material.dart';
import 'package:store_app/config/colors/colors.dart';
import 'package:store_app/model/productmodel/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product products;

  const ProductCard({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        color: whiteColor,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                products.thumbnail!,
                height: 180.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          products.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "\$${products.price}",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        "${products.rating}",
                        style:
                        GoogleFonts.poppins(fontSize: 14.0, color: Colors.grey),
                      ),
                      const SizedBox(width: 4.0),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            Icons.star,
                            size: 16.0,
                            color: index < (products.rating?.toInt() ?? 0)
                                ? Colors.amber
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "By ${products.brand}",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "In ${products.category}",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}