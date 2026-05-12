import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  //to do animation, change to stateful widget
  CategoriesScreen({super.key, required this.availableMeals});

  List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //if you use multiple animationcontrollers, use TickerProviderStateMixin

  //late is used to initialize the variable later(not yet when class is created)
  late AnimationController _animationController;

  //for animation, you add animation controller in initState(), as it must be set before build() executes
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController
        .forward(); //or .repeat(), which will restart the animation once it's done
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: ((ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3), //pushed 30% down from the screen
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        // position: _animationController.drive( //drive + tween to animate the position from lower & upper bound 
        //   Tween(
        //     begin: const Offset(0, 0.3), //pushed 30% down from the screen
        //     end: const Offset(0, 0),
        //   ),
        // ),
        child: child,
      )),
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //columns
          childAspectRatio: 3 / 2, //size of grid
          crossAxisSpacing: 20, //spacing of 20px horizontally
          mainAxisSpacing: 20,
        ), //spacing of 20px vertically
        children: [
          //for...in or availableCategories.map((category)=>CategoryGridItem(category: category)).toList();
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),

      // builder: (ctx, child) => Padding(
      //   padding: EdgeInsets.only(top: 100- 100*_animationController.value),
      //   child: child,//for performance optimization
    );
  }
}
