import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key, required this.availableMeals});

  List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category){
    final filteredMeals= availableMeals.where((meal)=> meal.categories.contains(category.id)).toList();
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealsScreen(title: category.title, meals: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //columns
              childAspectRatio: 3 / 2, //size of grid
              crossAxisSpacing: 20, //spacing of 20px horizontally
              mainAxisSpacing: 20), //spacing of 20px vertically
          children: [
            //for...in or availableCategories.map((category)=>CategoryGridItem(category: category)).toList();
            for (final category in availableCategories)
              CategoryGridItem(category: category, onSelectCategory: (){
                _selectCategory(context,category);
              },)
            ],
        );
  }
}
