import 'package:flutter/material.dart';

import '../models/food.dart';

class MyQuantitySelector extends StatelessWidget {

  final int quantity;
  final Food food;
  final VoidCallback onIncreament;
  final VoidCallback onDecreament;

  const MyQuantitySelector({
    super.key,
    required this.quantity,
    required this.food,
    required this.onDecreament,
    required this.onIncreament,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding:const EdgeInsets.all(9),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          //decrease buttom
          GestureDetector(
            onTap: onDecreament,
            child: Icon(
              Icons.remove,
              size: 20,
              color: Colors.grey.shade500,
            ),
          ),


          //quantity count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(
                  quantity.toString(),
              ),
                        ),
            ),
        ),    

          //increase buttom
          GestureDetector(
            onTap: onIncreament,
            child: Icon(
              Icons.add,
              size: 20,
              color: Colors.grey.shade500,
            ),
          ),


        ],
      ),
    );
  }
}