import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_plates_provider/View/widget/add.dart';
import 'package:recipe_plates_provider/View/widget/category_page.dart';
import 'package:recipe_plates_provider/View/widget/favorite_page.dart';
import 'package:recipe_plates_provider/View/widget/home.dart';
import 'package:recipe_plates_provider/View/widget/pie_chart.dart';
import 'package:recipe_plates_provider/controller/bottom_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key, required this.userName});
  final String userName;

  List get pages => [
        const HomePageWidget(userName: ''),
        const FavouritePageWidget(),
        const CategoryPageWidget(),
        PieChartPageWidget(),
      ];

  @override
  Widget build(BuildContext context) {
    final bttmProvider = Provider.of<BottomProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: pages[bttmProvider.currentIndexValue],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(22),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              unselectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => bttmProvider.bottomNav(index),
              backgroundColor: const Color.fromARGB(24, 7, 100, 95),
              currentIndex: bttmProvider.currentIndexValue,
              selectedItemColor: const Color.fromARGB(255, 9, 49, 83),
              unselectedItemColor: const Color.fromARGB(255, 145, 176, 239),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: 'ᴴᵒᵐᵉ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_sharp,
                    size: 25,
                  ),
                  label: 'ᶠᵃᵛᵒᵘʳⁱᵗᵉ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                    size: 25,
                  ),
                  label: 'ᶜᵃᵗᵉᵍᵒʳʸ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.donut_large_rounded,
                    size: 25,
                  ),
                  label: 'ᶜʰᵃʳᵗ',
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            top: 25,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPageWidget(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

GestureDetector buildImageSelectionOption(
    String iconPath, String label, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Lottie.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            Text(label),
          ],
        ),
      ),
    ),
  );
}
