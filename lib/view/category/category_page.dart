import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/bloc/CategoryBloc/category_bloc.dart';
import 'package:store_app/bloc/CategoryBloc/category_event.dart';
import 'package:store_app/bloc/CategoryBloc/category_state.dart';
import 'package:store_app/config/colors/colors.dart';
import 'package:store_app/main.dart';
import 'package:store_app/utills/enum.dart';
import 'package:store_app/view/category/widget/category_card.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(categoryRepository: getIt());
    _categoryBloc.add(FetchCategoriesEvent());
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Categories",
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
        create: (_) => _categoryBloc..add(FetchCategoriesEvent()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (BuildContext context, state) {
            final isCompleted = state.categoriesResponse.status == Status.COMPLETED;
            final isError = state.categoriesResponse.status == Status.ERROR;
            final categories = isCompleted ? (state.categoriesResponse.data ?? []) : [];

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
                        color: blackColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: greyColor),
                        hintText: 'Search categories',
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
                        context.read<CategoryBloc>().add(SearchCategoriesEvent(query: value));
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Display message or number of results
                  if (isCompleted && categories.isEmpty)
                    Text(
                      "No results found",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    )
                  else if (isCompleted)
                    Text(
                      "${categories.length} results found",
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.0),
                    ),
                  const SizedBox(height: 10.0),

                  // Category List or Error Message
                  if (isError)
                    Expanded(
                      child: Center(
                        child: Text(
                          "Error: ${state.categoriesResponse.message ?? 'Something went wrong'}",
                          style: GoogleFonts.poppins(color: Colors.red),
                        ),
                      ),
                    )
                  else if (isCompleted && categories.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No categories match your search.",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                    )
                  else if (isCompleted)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CategoryCard(
                              name: category.name,
                              slug: category.slug,
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
