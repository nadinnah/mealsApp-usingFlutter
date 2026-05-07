import 'package:flutter/material.dart';

import '../models/meal.dart';
import 'categories.dart';
import 'meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(Meal meal){
    if(_favoriteMeals.contains(meal)){
      setState(() {
        _favoriteMeals.remove(meal);
      });
    }else{
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }


  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage= CategoriesScreen(onToggleFavorite: (meal ){_toggleFavorite(meal); },);
    String activePageTitle = 'Categories';
    if(_selectedPageIndex==1){
      activePage= MealsScreen( meals: _favoriteMeals, onToggleFavorite: (Meal ) { _toggleFavorite(Meal); },);
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,

      bottomNavigationBar: BottomNavigationBar(currentIndex: _selectedPageIndex//controls which tab will be highlighted
          ,onTap: _selectPage, items: const[
        BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
      ]),
    );
  }
}
