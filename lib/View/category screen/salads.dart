import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/view/widget/menu.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';

class SaladsPage extends StatelessWidget {
  const SaladsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Salads',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Consumer<DbProvider>(
          builder: (context, recipeList, child) {
            final filteredSaladsList = recipeList.recipeNotifier
                .where((recipe) => recipe.category.toLowerCase() == 'salads')
                .toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredSaladsList.length,
              itemBuilder: (context, index) {
                final recipeData = filteredSaladsList[index];
                final recipeImage =
                    recipeData.image != null ? File(recipeData.image!) : null;
                return buildGridList(
                  context,
                  image: recipeImage,
                  text: recipeData.name,
                  category: recipeData.category,
                  description: recipeData.description,
                  ingredients: recipeData.ingredients,
                  cost: recipeData.cost,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildGridList(
    BuildContext context, {
    File? image,
    String? text,
    String? category,
    String? description,
    String? ingredients,
    String? cost,
  }) {
    double cardWidth = MediaQuery.of(context).size.width *
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.4
            : 0.2);
    double cardHeight = 120.0;

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 2, 36, 17),
              offset: Offset(3.0, 3.0),
              blurRadius: 1,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MenuOpeningPage(
                name: text,
                category: category,
                description: description!,
                ingredients: ingredients!,
                cost: cost!,
                selectedImagePath: image!,
              ),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.20),
                  child: image != null
                      ? Image.file(
                          image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          category!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 14, 7),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
