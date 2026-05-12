import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterMealsNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterMealsNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //state[filter]=isActive; //this wont work since state is immutable. (this mutates state in memory(not allowed))
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FilterMealsNotifier, Map<Filter, bool>>((ref) => FilterMealsNotifier());

//you can add multiple providers in the same class(closely related to each other)
final filteredMealsProvider= Provider((ref){
  final meals= ref.watch(mealsProvider); //watch is used to listen to changes in the provider
  final activeFilters= ref.watch(filtersProvider);

  return meals.where((meal){
    if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(activeFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();
});