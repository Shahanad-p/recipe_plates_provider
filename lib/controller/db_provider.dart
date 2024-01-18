import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/Services/services.dart';

class DbProvider extends ChangeNotifier {
  List<RecipeModel> result = [];
  List<RecipeModel> foundrecipe = [];
  List<RecipeModel> recipeList = [];
  List<RecipeModel> recipeNotifier = [];
  List<RecipeModel> favoriteItems = [];
  List<RecipeModel> favoriteItemsNotifier = [];
  DbServices dbservice = DbServices();

  getAllProvideByRecepe() async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    notifyListeners();
  }

  addProviderByReceipe(RecipeModel value) async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    await dbservice.addRecipies(value);
    getAllProvideByRecepe();
  }

  deleteProviderByReceipe(int index) async {
    await dbservice.deleteRecipies(index);
    getAllProvideByRecepe();
  }

  updateProviderByReceipe(RecipeModel value, index) async {
    final recipedb = await Hive.openBox<RecipeModel>('recipe_db');
    recipeNotifier.clear();
    recipeNotifier.addAll(recipedb.values);
    recipedb.putAt(index, value);
    getAllProvideByRecepe();
    notifyListeners();
  }

  getAllFavouriteProviderByRecipes() async {
    favoriteItems = await dbservice.getAllFavouriteRecipes();

    notifyListeners();
  }

  addToFavouriteProvider() async {
    recipeNotifier = List.from(recipeNotifier);
    favoriteItemsNotifier = favoriteItems;
  }

  addToFavourite(RecipeModel recipe, context) async {
    await dbservice.addToFavourite(recipe);
    bool isAlreadyInFavorites = favoriteItems.contains(recipe);
    if (!isAlreadyInFavorites) {
      favoriteItems.add(recipe);
      recipeNotifier = List.from(recipeNotifier);
    }
    notifyListeners();
  }

  deleteFromFavourite(int index, context) async {
    await dbservice.deleteFromFavourite(index);
    favoriteItems.removeAt(index);
    notifyListeners();
  }

  loadrecipes() {
    final allrecipes = recipeList;
    foundrecipe = allrecipes;
    notifyListeners();
    getAllProvideByRecepe();
  }

  filteredRecipes(String searchitem) {
    if (searchitem.isEmpty) {
      result = recipeList;
    } else {
      result = recipeList
          .where((RecipeModel recipe) =>
              recipe.name.toLowerCase().contains(searchitem.toLowerCase()))
          .toList();
    }
    foundrecipe = result;

    getAllProvideByRecepe();
    notifyListeners();
  }

  calculateTotalCost(List<RecipeModel> recipes) {
    double totalCost = 0;
    for (int i = 0; i < recipes.length; i++) {
      RecipeModel recipe = recipes[i];
      totalCost += double.parse(recipe.cost);
    }
    return totalCost;
  }
}
