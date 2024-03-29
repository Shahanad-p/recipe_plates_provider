import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/view/widget/edit_page.dart';
import 'package:recipe_plates_provider/view/widget/home_decorate.dart';
import 'package:recipe_plates_provider/view/widget/sidebar_drawer.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';
import 'package:recipe_plates_provider/controller/snackbar_provider.dart';

class HomePageWidget extends StatefulWidget {
  final String userName;

  const HomePageWidget({super.key, required this.userName});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<RecipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    super.initState();
    getProvider.getAllProvideByRecepe();
    displayedRecipes = getProvider.recipeNotifier;
    usernameController.dispose();
  }

  void filterRecipes(String query) {
    final getProvider = Provider.of<DbProvider>(context, listen: false);
    setState(() {
      displayedRecipes = getProvider.recipeNotifier
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final snackBarPro = Provider.of<SnackBarProvider>(context, listen: false);
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
              child: TextFormField(
                onChanged: (value) {
                  Provider.of<DbProvider>(context, listen: false)
                      .filteredRecipes(value);
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Consumer<DbProvider>(
                  builder: (context, value, child) {
                    final foundrecipe = value.recipeNotifier;
                    if (foundrecipe.isEmpty) {
                      return SizedBox(
                        height: 500,
                        child: Lottie.asset(
                          'assets/Animation - 1703913980311.json',
                          height: 125,
                          width: 125,
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
                      itemCount: foundrecipe.length,
                      itemBuilder: (context, index) {
                        final recipeDatas = value.recipeNotifier[index];
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
                              snackBarPro.deleteRecipies(context, index);
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
