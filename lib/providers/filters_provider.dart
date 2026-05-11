import 'package:flutter_riverpod/legacy.dart';

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

final filterMeals = StateNotifierProvider<FilterMealsNotifier, Map<Filter, bool>>((ref) => FilterMealsNotifier());
