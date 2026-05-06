import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){},
        child: Stack(//you use positioned widget inside the stack widget
          children: [
            FadeInImage(placeholder: MemoryImage(kTransparentImage),image: NetworkImage(meal.imageUrl),),
            Positioned(bottom:0,left: 0,right:0,child: Container(color: Colors.black54,))
          ]
        ),
      ),
    );
  }
}
