import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

void openLocationSearchBox(BuildContext context){
  showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: const Text("Your location"),
      content:const TextField(
        decoration: InputDecoration(hintText: "Search addres..."),
      ),
      actions: [
        //cancel buttom
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        //save buttom
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Save'),
        ),
        
      ],
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver Now", style: TextStyle(color: Colors.grey.shade500),),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                //addres
                Text("Jalana Danau Maninjau",
                 style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                //drop down menu
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          )
        ],
      ),
    );
  }
}