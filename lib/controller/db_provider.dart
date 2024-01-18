import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/Services/services.dart';

class DbProvider extends ChangeNotifier {
  // String search = '';

  List<recipeModel> recipeNotifier = [];
  List<recipeModel> favoriteItems = [];
  List<recipeModel> favoriteItemsNotifier = [];
  DbServices dbservice = DbServices();

  Future getAllProvideByRecepe() async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    notifyListeners();
  }

  Future addProviderByReceipe(recipeModel value) async {
    recipeNotifier = await dbservice.getAllRecipiesByList();
    await dbservice.addRecipies(value);
    getAllProvideByRecepe();
  }

  Future deleteProviderByReceipe(int index) async {
    await dbservice.deleteRecipies(index);
    getAllProvideByRecepe();
  }

  // Future updateProviderByReceipe(recipeModel newRecipe, index) async {
  //   await dbservice.updateRecipe(index, newRecipe);
  //   getAllProvideByRecepe();
  // }
  Future updateProviderByReceipe(recipeModel value, index) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    recipeNotifier.clear();
    recipeNotifier.addAll(recipedb.values);
    recipedb.putAt(index, value);
    getAllProvideByRecepe();
    notifyListeners();
  }

  Future getAllFavouriteProviderByRecipes() async {
    favoriteItems = await dbservice.getAllFavouriteRecipes();

    notifyListeners();
  }

  Future addToFavouriteProvider() async {
    recipeNotifier = List.from(recipeNotifier);
    favoriteItemsNotifier = favoriteItems;
  }

  Future<void> addToFavourite(recipeModel recipe, context) async {
    await dbservice.addToFavourite(recipe);
    bool isAlreadyInFavorites = favoriteItems.contains(recipe);
    if (!isAlreadyInFavorites) {
      favoriteItems.add(recipe);
      recipeNotifier = List.from(recipeNotifier);
    }
    notifyListeners();
  }

  Future<void> deleteFromFavourite(int index, context) async {
    await dbservice.deleteFromFavourite(index);
    favoriteItems.removeAt(index);
    notifyListeners();
  }

  // void searchResult(context) {
  //   final dbpro = Provider.of<DbProvider>(context, listen: false);
  //   final filteredRecipies = dbpro.recipeNotifier
  //       .where((recipeList) =>
  //           recipeList.name.toLowerCase().contains(search.toLowerCase()))
  //       .toList();
  //   dbpro.filteredRecipes(filteredRecipies);
  //   notifyListeners();
  // }

  calculateTotalCost(List<recipeModel> recipes) {
    double totalCost = 0;
    for (int i = 0; i < recipes.length; i++) {
      recipeModel recipe = recipes[i];
      totalCost += double.parse(recipe.cost);
    }
    return totalCost;
  }
}
