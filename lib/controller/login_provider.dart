// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/View/widget/bottom_navigation.dart';
import 'package:recipe_plates_provider/View/widget/login_page.dart';
import 'package:recipe_plates_provider/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  void checkLogin(BuildContext context) async {
    final userName = usernameController.text;

    if (userName.isNotEmpty) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool(save_key_name, true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNavBarWidget(
            userName: userName,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are logged in..!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('Please enter a username'),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> goToLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageWidget()));
    notifyListeners();
  }

  Future<void> checkUserLoggedIn(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(save_key_name);
    if (userLoggedIn == null || userLoggedIn == false) {
      goToLogin(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBarWidget(userName: ''),
        ),
      );
    }

    notifyListeners();
  }

  signOut(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPageWidget()),
        (route) => false);

    notifyListeners();
  }
}
