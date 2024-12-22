import 'package:flutter/material.dart';

class MyButtom extends StatelessWidget {
  final void Function()? onTap;
  final String text;


  const MyButtom({
    super.key,
    required this.onTap,
    required this.text,
    }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(



        //padding inside
        padding:const EdgeInsets.all(25),
        decoration: BoxDecoration(
          //collort Buttom
          color: Theme.of(context,).colorScheme.tertiary,

          //curved corners
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            ),
          ),
      ),
    );
  }
}