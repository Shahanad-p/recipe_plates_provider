// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/view/widget/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> resetRecipe(BuildContext context) async {
  bool confirmResetDatas = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 229, 232, 227),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "This will be delete your all recipies. Do you want to continue..?",
                style: TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(height: 10.20),
              Lottie.asset('assets/Animation - 1703841326068.json',
                  height: 50.10, width: 50)
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              "Reset",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmResetDatas == true) {
    final clearAllRecipe = await Hive.openBox<RecipeModel>('recipe_db');
    final clearAllFavourite = await Hive.openBox<RecipeModel>('favorite_db');
    final sharedPref = await SharedPreferences.getInstance();
    clearAllRecipe.clear();
    clearAllFavourite.clear();
    sharedPref.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreenWidget(),
      ),
    );
  }
}
