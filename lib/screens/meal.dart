import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_detail.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.mealDetails, required this.id});

  final String id;
  final Meal mealDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),//will need clip behavior or it wont work with stack
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: Stack(//you use positioned widget inside the stack widget
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(mealDetails.imageUrl),
              fit: BoxFit.cover,//makes sure image is never distorted, but zoomed in
              height: 200,
              width: double.infinity, //imp to use as much width with the 200 height
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black54,
                  child: Column(children: [

                  ]
                  ),
                ))
          ]),
    ));
  }
}
