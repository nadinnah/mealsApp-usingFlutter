import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //will need clip behavior or it wont work with stack
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(//you use positioned widget inside the stack widget
            children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            fit: BoxFit.cover,
            //makes sure image is never distorted, but zoomed in
            height: 200,
            width:
                double.infinity, //imp to use as much width with the 200 height
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.work,
                            label: meal.complexity.name[0].toUpperCase() +
                                meal.complexity.name.substring(1)),
                        //substring(1) gets you the string without the first character, name[0] gets you the first character
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money,
                            label: meal.affordability.name[0].toUpperCase() +
                                meal.affordability.name.substring(1)),
                      ],
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
