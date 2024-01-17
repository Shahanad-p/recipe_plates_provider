// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/View/widget/bottom_navigation.dart';
import 'package:recipe_plates_provider/View/widget/login_page.dart';
import 'package:recipe_plates_provider/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key});

  Future<void> goToLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPageWidget()));
  }

  Future<void> checkUserLoggedIn(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(save_key_name);
    if (userLoggedIn == null || userLoggedIn == false) {
      goToLogin(context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavBarWidget(userName: '')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
            future: checkUserLoggedIn(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/side-view-mushroom-frying-with-stove-spice-human-hand-pan (1).jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
