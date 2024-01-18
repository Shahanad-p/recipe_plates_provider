import 'package:hive_flutter/adapters.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class DbServices {
  Future addRecipies(recipeModel value) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    return recipedb.add(value);
  }

  Future getAllRecipiesByList() async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    return recipedb.values.toList();
  }

  Future deleteRecipies(int index) async {
    final recipedb = await Hive.openBox<recipeModel>('recipe_db');
    recipedb.deleteAt(index);
  }

  // Future<void> updateRecipe(int index, recipeModel newRecipe) async {
  //   final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
  //   recipeDB.putAt(index, newRecipe);
  // }

  Future getAllFavouriteRecipes() async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
    return favoriteBox.values.toList();
  }

  Future addToFavourite(recipeModel recipe) async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');

    return favoriteBox.add(recipe);
  }

  Future<void> deleteFromFavourite(int index) async {
    final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
    favoriteBox.deleteAt(index);
  }
}
