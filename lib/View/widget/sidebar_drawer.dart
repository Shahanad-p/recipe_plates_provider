// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/View/sidebar%20drawer/about_page.dart';
import 'package:recipe_plates_provider/View/sidebar%20drawer/data_reset.dart';
import 'package:recipe_plates_provider/View/sidebar%20drawer/setting_page.dart';
import 'package:recipe_plates_provider/View/sidebar%20drawer/terms_condions_page.dart';
import 'package:recipe_plates_provider/controller/login_provider.dart';

class SideBarDrawer extends StatelessWidget {
  const SideBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Drawer(
        shadowColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Lottie.asset(
                    'assets/Animation - 1702443956870.json',
                    height: 300,
                    width: 250,
                    repeat: true,
                    reverse: true,
                  ),
                  const Text(
                    'Recipe Plate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'About',
              icon: Icons.error_outline,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'Terms & Conditions',
              icon: Icons.description_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: 'Reset',
              icon: Icons.restart_alt,
              onClicked: () => selectedItem(context, 3),
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout_outlined,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.grey;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    final logoutProvider = Provider.of<LoginProvider>(context, listen: false);
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SettingPageWidget()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AboutPageWidget()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TermsConditionsPageWidget(),
          ),
        );
        break;
      case 3:
        resetRecipe(context);
        break;
      case 4:
        logoutProvider.signOut(context);
        break;
    }
  }
}
