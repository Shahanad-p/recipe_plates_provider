import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Controller/home_provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/View/widget/delete_snakbar.dart';
import 'package:recipe_plates_provider/View/widget/edit_page.dart';
import 'package:recipe_plates_provider/View/widget/home_decorate.dart';
import 'package:recipe_plates_provider/View/widget/sidebar_drawer.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';

class HomePageWidget extends StatelessWidget {
  final String userName;

  const HomePageWidget({super.key, required this.userName});
  void deleteRecipies(BuildContext context, int index) {
    showDeleteConfirmationDialog(context, index).then((confirmed) {
      if (confirmed != null && confirmed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe deleted successfully.!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    getProvider.getAllProvideByRecepe();
    return SafeArea(
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
          title: const Text('Home',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        drawer: const SideBarDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 35),
            const Text(
              'What\'s in your kitchen..?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Consumer<HomeScreenProvider>(
                builder: (context, searchProvider, child) {
                  return TextField(
                    onChanged: (value) {
                      searchProvider.search = value;
                      searchProvider.searchResult(context);
                    },
                    decoration: InputDecoration(
                      label: const Text('Search'),
                      hintText: 'Search your recipes here..!',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Consumer<DbProvider>(
                  builder: (context, value, child) {
                    final displayedRecipes = value.recipeNotifier;
                    if (displayedRecipes.isEmpty) {
                      return SizedBox(
                        height: 500,
                        child: Lottie.asset(
                          'assets/Animation - 1703913980311.json',
                          height: 135,
                          width: 135,
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: displayedRecipes.length,
                      itemBuilder: (context, index) {
                        final recipeDatas = displayedRecipes[index];
                        File? recipeImage;
                        if (recipeDatas.image != null) {
                          recipeImage = File(recipeDatas.image!);
                        }
                        return buildGridList(
                          context,
                          image: recipeImage,
                          icon: Icons.favorite_border_outlined,
                          text: recipeDatas.name,
                          category: recipeDatas.category,
                          description: recipeDatas.description,
                          ingredients: recipeDatas.ingredients,
                          cost: recipeDatas.cost,
                          editIcon: IconButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditPageWidget(
                                    index: index,
                                    name: recipeDatas.name,
                                    category: recipeDatas.category,
                                    description: recipeDatas.description,
                                    ingredients: recipeDatas.ingredients,
                                    cost: recipeDatas.cost,
                                    image: recipeDatas.image,
                                  ),
                                ),
                              );
                              //   final result = await Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => EditPageWidget(
                              //       index: index,
                              //       name: recipeDatas.name,
                              //       category: recipeDatas.category,
                              //       description: recipeDatas.description,
                              //       ingredients: recipeDatas.ingredients,
                              //       cost: recipeDatas.cost,
                              //       image: recipeDatas.image,
                              //     ),
                              //   ),
                              // );
                              // if (result != null && result is recipeModel) {
                              //   // Logic for editing
                              // }
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 34, 123, 37),
                              ),
                            ),
                          ),
                          deleteIcon: IconButton(
                            onPressed: () {
                              deleteRecipies(context, index);
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 148, 37, 29),
                              ),
                            ),
                          ),
                          addToFavorite: () {
                            value.addToFavourite(recipeDatas, context);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
