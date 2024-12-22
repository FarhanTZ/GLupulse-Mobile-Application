import 'package:finpro/features/auth/presentation/components/my_buttom.dart';
import 'package:finpro/features/menu%20makanan/presentation/Components/my_cart_tile.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';
import 'package:finpro/features/menu%20makanan/presentation/pages/payment_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPages extends StatelessWidget {
  const CartPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child){
      //cart
      final userCart = restaurant.cart;

      //scaffold UI
      return Scaffold(
        appBar : AppBar(  
          title:const Text("Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey.shade500,
          actions: [
            //clear all cart buttom
            IconButton(
            onPressed: (){
              showDialog(context: context, 
              builder: (context) => AlertDialog(
                title: const Text("are you sure you want to clear the cart?"),
                actions: [
                  //cance bottom
                  TextButton(
                    onPressed: ()=> Navigator.pop(context), 
                    child:const Text("Cance")
                    ),

                  //yes bottom
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      restaurant.clearCart();
                    },
                    child:const Text("Yes"),
                    ),

                ],
              )
              );
            },
            icon:const Icon(Icons.delete)
            ),
          ],
        ),

        body: Column(
          children: [

            //list of cart
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty 
                    ? const Expanded(
                      child: Center(child: Text("Cart is empty..."),
                        ),
                      )
                    : Expanded(
                    child: ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
              
                        //get individual cart item
                        final cartItem = userCart[index];
              
              
                        //return cart tile ui
                        return MyCartTile(cartItem: cartItem);
                      },
                    ),
                  ),
                ],
              ),
            ),

            //buttom pay
            MyButtom(
              onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentPages(),
                ),
              ), 
              text: "Go to checkout",
            ),

            const SizedBox(height: 26),
          ],
        ),
        );
      }
    );
  }
}