import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/View/widget/delete_snakbar.dart';
import 'package:recipe_plates_provider/View/widget/edit_page.dart';
import 'package:recipe_plates_provider/View/widget/home_decorate.dart';
import 'package:recipe_plates_provider/View/widget/sidebar_drawer.dart';
import 'package:recipe_plates_provider/controller/db_provider.dart';
import 'package:recipe_plates_provider/controller/home_provider.dart';

class HomePageWidget extends StatefulWidget {
  final String userName;
  const HomePageWidget({super.key, required this.userName});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<recipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final getHomeProvider = Provider.of<DbProvider>(context, listen: false);
    final homescreenprovider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    getHomeProvider.getAllProvideByRecepe();
    homescreenprovider.int(getHomeProvider.recipeNotifier);
    usernameController.dispose();
  }

  void filterRecipes(String query) {
    final getHomeProvider = Provider.of<DbProvider>(context, listen: false);
    setState(() {
      displayedRecipes = getHomeProvider.recipeNotifier
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void deleteRecipies(int index) {
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
    Provider.of<DbProvider>(context, listen: false).getAllProvideByRecepe();
    final home = Provider.of<HomeScreenProvider>(context, listen: false);
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
              child: TextField(
                controller: searchController,
                onChanged: filterRecipes,
                decoration: InputDecoration(
                  label: const Text('Search'),
                  hintText: 'Search your recipes here..!',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Consumer<DbProvider>(
                  builder: (context, value, child) {
                    if (displayedRecipes.isEmpty) {
                      return SizedBox(
                        height: 500,
                        child: Lottie.asset(
                            'assets/Animation - 1703913980311.json',
                            height: 135,
                            width: 135),
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
                              final result = await Navigator.of(context).push(
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

                              if (result != null && result is recipeModel) {
                                home.edit(index, result);
                              }
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 34, 123, 37),
                            ),
                          ),
                          deleteIcon: IconButton(
                            onPressed: () {
                              deleteRecipies(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 148, 37, 29),
                            ),
                          ),
                          addToFavorite: () {
                            value.addToFavourite(recipeDatas, context);
                          },
                          onDelete: () {},
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
