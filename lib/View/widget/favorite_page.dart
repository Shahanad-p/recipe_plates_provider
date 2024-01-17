import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/View/widget/menu.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';

class FavouritePageWidget extends StatelessWidget {
  const FavouritePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DbProvider>(context, listen: false);
    prov.getAllFavouriteProviderByRecipes();
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: const Text(
              'Favourites',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Consumer<DbProvider>(
            builder: (context, favoriteList, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: favoriteList.favoriteItems.length,
                  itemBuilder: (context, index) {
                    final recipe = favoriteList.favoriteItems[index];
                    return buildGridItem(
                      image: recipe.image,
                      text1: recipe.name,
                      index: index,
                      recipe: recipe,
                      context: context,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildGridItem({
    required String? image,
    required String text1,
    required int index,
    required recipeModel recipe,
    required BuildContext context,
  }) {
    final deleteFvrteProvider = Provider.of<DbProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.10),
      child: Container(
        height: 160,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 184, 177, 177),
              offset: Offset(8.0, 8.0),
              blurRadius: 1,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              offset: Offset(-3.0, -3.0),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MenuOpeningPage(
                      name: recipe.name,
                      category: recipe.category,
                      description: recipe.description,
                      ingredients: recipe.ingredients,
                      cost: recipe.cost,
                      selectedImagePath: File(recipe.image!),
                    )));
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(image),
                    height: 160,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    deleteFvrteProvider.deleteFromFavourite(index, context);
                  },
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 20, 60, 130),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
