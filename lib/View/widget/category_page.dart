import 'package:flutter/material.dart';
import 'package:recipe_plates_provider/View/category%20screen/beverages.dart';
import 'package:recipe_plates_provider/View/category%20screen/desserts.dart';
import 'package:recipe_plates_provider/View/category%20screen/fastfood.dart';
import 'package:recipe_plates_provider/View/category%20screen/grilled.dart';
import 'package:recipe_plates_provider/View/category%20screen/healthy.dart';
import 'package:recipe_plates_provider/View/category%20screen/salads.dart';
import 'package:recipe_plates_provider/View/category%20screen/snacks.dart';
import 'package:recipe_plates_provider/View/category%20screen/soup.dart';


class CategoryPageWidget extends StatelessWidget {
  const CategoryPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: const Text(
              'Categories',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BeveragesPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Beverages',
                    imagePath:
                        'assets/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FastfoodPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Fastfood',
                    imagePath:
                        'assets/—Pngtree—creative cartoon burger vector material_3177179.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SaladsPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Salads',
                    imagePath: 'assets/48049.jpg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DessertsPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Desserts',
                    imagePath: 'assets/xj5t_6v6e_220330.jpg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HealthyPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Healthy',
                    imagePath: 'assets/3631249.jpg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GrilledPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Grilled',
                    imagePath: 'assets/13011.jpg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SnacksPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Snacks',
                    imagePath: 'assets/3730825.jpg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SoupPage()));
                  },
                  child: buildCategoriesBox(
                    context: context,
                    category: 'Soup',
                    imagePath: 'assets/6339776.jpg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoriesBox(
      {required context, required String category, required String imagePath}) {
    double cardWidth = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
      ),
      child: Container(
        height: 55,
        width: cardWidth,
        margin: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color.fromARGB(255, 222, 215, 215)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 176, 194, 178),
              offset: Offset(6.0, 6.0),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              blurRadius: 1,
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Image.asset(
                imagePath,
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
