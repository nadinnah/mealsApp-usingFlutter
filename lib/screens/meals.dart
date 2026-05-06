import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meal.dart';

import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal mealItem){

    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealScreen(id: mealItem.id, mealDetails: mealItem)));
  }

  @override
  Widget build(BuildContext context) {

    Widget content =
        ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: (){
            _selectMeal(context, meals[index]);
          }));

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("No meals available", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),),
            const SizedBox(
              height: 16,
            ),
            Text(
              "try selecting a different category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
