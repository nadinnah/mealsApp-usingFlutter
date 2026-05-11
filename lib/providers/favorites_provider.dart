import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meal.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier():super([]);

  toggleFavoriteStatus(Meal meal){
    final mealIsFavorite= state.contains(meal);

    if(mealIsFavorite){
      state= state.where((m)=>m.id != meal.id).toList();
    }else{
      state=[...state , meal];
    }
  }
}

//since data inside favoriteMealProvider changes, Provider() wont work
//use StateNotifierProvider() instead.
final favoriteMealsProvider= StateNotifierProvider((ref){
  return FavoriteMealsNotifier();
});