import 'package:hive_flutter/adapters.dart';
import 'package:recipe_plates_provider/Model/model.dart';

class DbServices {
  addRecipies(RecipeModel value) async {
    final recipedb = await Hive.openBox<RecipeModel>('recipe_db');
    return recipedb.add(value);
  }

  getAllRecipiesByList() async {
    final recipedb = await Hive.openBox<RecipeModel>('recipe_db');
    return recipedb.values.toList();
  }

  deleteRecipies(int index) async {
    final recipedb = await Hive.openBox<RecipeModel>('recipe_db');
    recipedb.deleteAt(index);
  }

  updateRecipe(int index, RecipeModel value) async {
    final recipedb = await Hive.openBox<RecipeModel>('recipe_db');
    recipedb.putAt(index, value);
  }

  getAllFavouriteRecipes() async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorite_db');
    return favoriteBox.values.toList();
  }

  addToFavourite(RecipeModel recipe) async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorite_db');
    return favoriteBox.add(recipe);
  }

  deleteFromFavourite(int index) async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorite_db');
    favoriteBox.deleteAt(index);
  }
}
