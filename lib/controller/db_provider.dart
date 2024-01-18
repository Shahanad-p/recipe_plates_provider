import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/Services/services.dart';

class DbProvider extends ChangeNotifier {
  List<recipeModel> result = [];
  List<recipeModel> foundrecipe = [];
  List<recipeModel> recipeList = [];
  List<recipeModel> recipeNotifier = [];
  List<recipeModel> favoriteItems = [];
  List<recipeModel> favoriteItemsNotifier = [];
  DbServices dbservice = DbServices();

  getAllProvideByRecepe() async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    notifyListeners();
  }

  addProviderByReceipe(recipeModel value) async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    await dbservice.addRecipies(value);
    getAllProvideByRecepe();
  }

  deleteProviderByReceipe(int index) async {
    await dbservice.deleteRecipies(index);
    getAllProvideByRecepe();
  }

  updateProviderByReceipe(recipeModel value, index) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
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

  addToFavourite(recipeModel recipe, context) async {
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
          .where((recipeModel recipe) =>
              recipe.name.toLowerCase().contains(searchitem.toLowerCase()))
          .toList();
    }
    foundrecipe = result;

    getAllProvideByRecepe();
    notifyListeners();
  }

  calculateTotalCost(List<recipeModel> recipes) {
    double totalCost = 0;
    for (int i = 0; i < recipes.length; i++) {
      recipeModel recipe = recipes[i];
      totalCost += double.parse(recipe.cost);
    }
    return totalCost;
  }
}
