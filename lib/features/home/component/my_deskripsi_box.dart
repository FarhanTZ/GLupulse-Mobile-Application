import 'package:flutter/material.dart';

class MyDeskripsiBox extends StatelessWidget {
  const MyDeskripsiBox({super.key});

  @override
  Widget build(BuildContext context) {

      // textstyle
      var MyPrimaryTextStyle = TextStyle(
        color: Colors.grey.shade700
      );

      var MySecondTextStyle = TextStyle(
        color: Colors.grey.shade500
      );


    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.all(25),
      margin:const EdgeInsets.only(left: 25,right: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //delivery fee
        Column(children: [
          Text('\$0.99',style: MyPrimaryTextStyle,),
          Text('Delivery fee',style: MySecondTextStyle,),
        ],
      ),

          //delivery time
        Column(children: [
          Text('15 - 30 min',style: MyPrimaryTextStyle,),
          Text('Delivery time',style: MySecondTextStyle,),
        ],
      ),


        ],
      ),
    );
  }
}