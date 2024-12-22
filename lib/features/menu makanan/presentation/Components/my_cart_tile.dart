import 'package:finpro/features/menu%20makanan/presentation/Components/my_quantity_selector.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/cart_item.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(9)
        ),
        margin:const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      height: 100,
                      width: 100,
                      ),
                  ),
              
                  const SizedBox(width: 10,),
              
                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    //food name
                    Text(cartItem.food.name),
              
                    //food price
                    Text('\$${cartItem.food.price}',
                    style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),

                const Spacer(),
              
                  const SizedBox(width: 10,),
                  //increament or decreamnt quantity
                  MyQuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food, 
                    onDecreament: (){
                      restaurant.removeFromCart(cartItem);
                    }, 
                    onIncreament: (){
                      restaurant.addtoCart(cartItem.food, cartItem.selectedAddon);
                    }
                    )
                ],
              ),
            ),

            //addons
            SizedBox(
              height: cartItem.selectedAddon.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:const EdgeInsets.only(left: 10,bottom: 10, right: 10),
                children: cartItem.selectedAddon
                  .map((addon)=> Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Row(
                        children: [
                          //addon name
                          Text(addon.name),
                    
                    
                          //addon price
                          Text('(\$ ${addon.price})'),
                        ],
                      ), 
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.grey.shade300)
                      ),
                      onSelected: (value){},
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                        ),
                  ),
                    ) 
                    .toList()),
              ),
          ],
          ),
        ),
      );
  }
}