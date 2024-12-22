import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodTile extends StatelessWidget {

  final Food food;
  final void Function()? onTap;

  const FoodTile({
  super.key, 
  required this.food,
  required this.onTap,
  }
);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
            
              //text food details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name),

                  Text(
                    '\$${food.price}',
                    style: TextStyle(
                      color: Colors.grey.shade500
                      ),
                    ),
                    const SizedBox(height: 10,),

                  Text(
                    food.description, 
                    style: TextStyle(
                      color: Colors.grey.shade700
                    ),
                  ),
                ],
              ),
            ),
            

            const SizedBox(width: 15,),

              //food image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(food.imagePath,height: 120,)),
            
            ]),
          ),
        ),


        //divide line
        const Divider(
          color: Colors.white,
          endIndent: 25,
          indent: 25,
          ),
      ],
    );
  }
}