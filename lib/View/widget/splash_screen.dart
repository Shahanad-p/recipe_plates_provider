// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/controller/login_provider.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
            future: splashProvider.checkUserLoggedIn(context),
            // initialData: null, // Provide initialData as null
            builder: (context, value) {
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
            },
          ),
        ),
      ),
    );
  }
}
