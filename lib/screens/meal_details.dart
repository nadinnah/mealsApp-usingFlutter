import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){onToggleFavorite(meal);}, icon: Icon(Icons.star))
          ],
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(children:[
            //unlike column widget, listView widget is not centered by default
            Image.network(meal.imageUrl, width: double.infinity,
            height: 300,
            fit: BoxFit.cover,),
            SizedBox(height: 14,),
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Theme.of(context).colorScheme.primary)),
            for(final meal in meal.ingredients)
              Text(meal,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.onPrimary),)
            ,SizedBox(height: 24,),
            Text('Steps', style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Theme.of(context).colorScheme.primary)),
            for(final meal in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(meal,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.onPrimary),),
              )
            ,SizedBox(height: 24,),
              ]),
        ));
  }
}
