// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/Model/model.dart';
import 'package:recipe_plates_provider/View/widget/splash_screen.dart';
import 'package:recipe_plates_provider/Controller/add_provider.dart';
import 'package:recipe_plates_provider/Controller/db_provider.dart';
import 'package:recipe_plates_provider/controller/bottom_provider.dart';
import 'package:recipe_plates_provider/controller/edit_provider.dart';
import 'package:recipe_plates_provider/controller/login_provider.dart';
import 'package:recipe_plates_provider/controller/snackbar_provider.dart';

const save_key_name = 'UserLoggedIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(recipeModelAdapter().typeId)) {
    Hive.registerAdapter(recipeModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddScreenProvider()),
        ChangeNotifierProvider(create: (context) => SnackBarProvider()),
        ChangeNotifierProvider(create: (context) => DbProvider()),
        ChangeNotifierProvider(create: (context) => BottomProvider()),
        ChangeNotifierProvider(create: (context) => EditProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenWidget(),
      ),
    );
  }
}
