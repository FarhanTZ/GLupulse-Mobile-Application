import 'package:finpro/features/menu%20makanan/presentation/pages/cart_pages.dart';
import 'package:flutter/material.dart';

class MySilverAppBar extends StatelessWidget {
  
  final Widget child;
  final Widget title;

  const MySilverAppBar({super.key, 
  required this.child, 
  required this.title,}
  );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        //cart buttom
        IconButton(onPressed: () {
          //go to cart page
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const CartPages(),
              ),
            );
        },
        icon:const Icon(Icons.shopping_cart)),
      ],
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey.shade700,
      title: const Text("Menu Makanan"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.5),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}