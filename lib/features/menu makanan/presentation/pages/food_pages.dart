import 'package:finpro/features/auth/presentation/components/my_buttom.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/food.dart';

class FoodPages extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddon = {};
  FoodPages({
    super.key, 
    required this.food
    }){
      //initialize selected addons to be false
      for (Addon addon in food.availableAddons){
        selectedAddon[addon] = false;
      }
    }

  @override
  State<FoodPages> createState() => _FoodPagesState();
}

class _FoodPagesState extends State<FoodPages> {

  //method to add to Cart
  void addToCart(Food food, Map<Addon, bool> selectedAddon){

    //close the current food page to go back to menu
    Navigator.pop(context);


    //format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons){
      if (widget.selectedAddon[addon] == true){
        currentlySelectedAddons.add(addon);
      }
    }

    //add to cart
    context.read<Restaurant>().addtoCart(food, currentlySelectedAddons);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        //scaffold ui
        Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
          children: [
        
        
            //food images
            Image.asset(widget.food.imagePath),
        
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //food name
              Text(
                widget.food.name, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20,
                ),
              ),
              
        
              //food price
              Text(
                '\$${widget.food.price}', 
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500
                ),
              ),
              
              const SizedBox(height: 10,),
              //food description
              Text(
                widget.food.description, 
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500
                ),
              ),
        
        
              const SizedBox(height: 10,),
              
              Divider(color: Colors.grey.shade300,),
        
              const SizedBox(height: 10,),
              
              //addons
              Text(
                "Add-ons",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                    ),
                  ),
        
              const SizedBox(height: 10,),
        
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.food.availableAddons.length,
                  itemBuilder: (context, index) {
                  //get individual addon
                  Addon addon = widget.food.availableAddons[index];
                
                
                  //return checkbox ui
                  return CheckboxListTile(
                    title: Text(addon.name),
                    subtitle: Text(
                      '\$${addon.price}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        ),
                      ),
                    value: widget.selectedAddon[addon], 
                    onChanged: (bool? value){
                      setState(() {
                        widget.selectedAddon[addon] = value!;
                      });
                    },
                      );
                    },
                  ),
              )
              ],
                      ),
            ),
          
            //buttom --> add to cart
            MyButtom(
              onTap:() => addToCart(widget.food,widget.selectedAddon), 
              text: "Add to cart",
            ),


            const SizedBox(height: 25,),

          ],
        ),
      ),
    ),

        //back buttom
        SafeArea(
          child: Opacity(
            opacity: 0.9,
            child: Container(
              margin:const EdgeInsets.only(left: 25),
              decoration: 
                BoxDecoration(color: Colors.grey.shade300,
                shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon:const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
            ),
          ),
        ),
    ],);
  }
}