import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_bloc.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_event.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_state.dart';
import 'package:store_app/config/colors/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: blackColor,
              style: GoogleFonts.poppins(
                color: blackColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: greyColor),
                hintText: 'Search favourites',
                hintStyle: GoogleFonts.poppins(color: greyColor),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: blackColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: blackColor, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: blackColor, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                context
                    .read<FavoriteBloc>()
                    .add(SearchFavoritesEvent(query: value));
              },
            ),
          ),
          // Wrapping ListView with Expanded to provide it with constraints
          Expanded(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  // Show loading spinner only during the loading state
                  return const Center(
                    child: CircularProgressIndicator(color: blackColor),
                  );
                } else if (state is FavoriteLoaded) {
                  if (state.favorites.isNotEmpty) {
                    // Show the list of favorites if data exists
                    return ListView.builder(
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        final product = state.favorites[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                            border: Border(
                              left: BorderSide(color: Colors.grey.shade300, width: 1),
                              right: BorderSide(color: Colors.grey.shade300, width: 1),
                              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 30,
                                  backgroundImage:
                                  NetworkImage(product.thumbnail!),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "\$${product.price.toString()}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            product.rating.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Row(
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < product.rating.round()
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                                size: 16,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<FavoriteBloc>()
                                        .add(RemoveFromFavoritesEvent(product));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // Show "No favorites found" if the favorites list is empty
                    return Center(
                      child: Text(
                        "No favorites found.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                } else if (state is FavoriteInitial) {
                  // Show "No favorites found" at the initial state
                  return Center(
                    child: Text(
                      "No favorites found.",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  // Handle any unexpected state
                  return Center(
                    child: Text(
                      "Something went wrong.",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}