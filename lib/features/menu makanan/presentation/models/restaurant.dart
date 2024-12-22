import 'package:collection/collection.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'food.dart';

class Restaurant extends ChangeNotifier {
  // List of menu items
  final List<Food> _menu =  [
    // Main course
    Food(
      name: 'Grilled Salmon',
      description: 'Grilled salmon with lemon butter sauce',
      imagePath: 'assets/menu/Grilled_Salmon.jpeg',
      price: 25.00,
      category: FoodCategory.main,
      availableAddons: [
        Addon(name: 'Mashed Potatoes', price: 2.00),
        Addon(name: 'Steamed Vegetables', price: 1.50),
        Addon(name: 'Garlic Bread', price: 1.00),
      ],
    ),
    Food(
      name: 'Steak',
      description: 'Tenderloin steak with peppercorn sauce',
      imagePath: 'assets/menu/Steak.jpeg',
      price: 30.00,
      category: FoodCategory.main,
      availableAddons: [
        Addon(name: 'French Fries', price: 1.50),
        Addon(name: 'Garlic Bread', price: 1.00),
      ],
    ),
    Food(
      name: 'Chicken Parmesan',
      description: 'Crispy breaded chicken with marinara sauce and cheese',
      imagePath: 'assets/menu/Chicken_Parmesan.jpeg',
      price: 22.00,
      category: FoodCategory.main,
      availableAddons: [
        Addon(name: 'Pasta', price: 2.00),
        Addon(name: 'Garlic Bread', price: 1.00),
      ],
    ),
    Food(
      name: 'Seafood Pasta',
      description: 'Penne pasta with shrimp, mussels, and clams in a creamy sauce',
      imagePath: 'assets/menu/Seafood_Pasta.jpeg',
      price: 28.00,
      category: FoodCategory.main,
      availableAddons: [
        Addon(name: 'Garlic Bread', price: 1.00),
      ],
    ),
    Food(
      name: 'Vegetarian Curry',
      description: 'Spicy vegetable curry with rice',
      imagePath: 'assets/menu/Vegetarian_Curry.jpeg',
      price: 20.00,
      category: FoodCategory.main,
      availableAddons: [
        Addon(name: 'Naan Bread', price: 1.50),
      ],
    ),

    // Salads
    Food(
      name: 'Caesar Salad',
      description: 'Crisp romaine lettuce with Caesar dressing, croutons, and Parmesan cheese',
      imagePath: 'assets/menu/Caesar_Salad.jpeg',
      price: 12.00,
      category: FoodCategory.salads,
      availableAddons: [],

    ),
    Food(
      name: 'Greek Salad',
      description: 'Fresh tomatoes, cucumbers, olives, feta cheese, and red onion with a lemon-herb dressing',
      imagePath: 'assets/menu/Greek_Salad.jpeg',
      price: 10.00,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: 'Cobb Salad',
      description: 'Mixed greens with grilled chicken, bacon, eggs, avocado, and blue cheese dressing',
      imagePath: 'assets/menu/Cobb_Salad.jpeg',
      price: 15.00,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: 'Asian Salad',
      description: 'Mixed greens with carrots, edamame, and a ginger-soy dressing',
      imagePath: 'assets/menu/Asian_Salad.jpeg',
      price: 12.00,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: 'Quinoa Salad',
      description: 'Quinoa with vegetables and a lemon-dill dressing',
      imagePath: 'assets/menu/Caesar_Salad.jpeg',
      price: 10.00,
      category: FoodCategory.salads,
      availableAddons: [],
    ),

    // Sides
    Food(
      name: 'French Fries',
      description: 'Crispy golden brown fries',
      imagePath: 'assets/menu/French_Fries.jpeg',
      price: 3.00,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    Food(
      name: 'Mashed Potatoes',
      description: 'Creamy mashed potatoes',
      imagePath: 'assets/menu/Mashed_Potatoes.jpeg',
      price: 3.50,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    Food(
      name: 'Steamed Vegetables',
      description: 'A medley of fresh steamed vegetables',
      imagePath: 'assets/menu/Steamed_Vegetables.jpeg',
      price: 2.50,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    Food(
      name: 'Garlic Bread',
      description: 'Warm, buttery garlic bread',
      imagePath: 'assets/menu/Garlic_Bread.jpeg',
      price: 1.00,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    Food(
      name: 'Rice',
      description: 'Steamed white rice',
      imagePath: 'assets/menu/Rice.jpeg',
      price: 2.00,
      category: FoodCategory.sides,
      availableAddons: [],
    ),

    // Desserts
    Food(
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with molten chocolate center',
      imagePath: 'assets/menu/Chocolate_Lava_Cake.jpeg',
      price: 6.00,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: 'Cheesecake',
      description: 'Classic New York-style cheesecake',
      imagePath: 'assets/menu/Cheesecake.jpeg',
      price: 7.00,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: 'Ice Cream Sundae',
      description: 'Vanilla ice cream with chocolate syrup, sprinkles, and whipped cream',
      imagePath: 'assets/menu/Ice_Cream_Sundae.jpeg',
      price: 5.00,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: 'Apple Pie',
      description: 'Warm apple pie with a flaky crust',
      imagePath: 'assets/menu/Apple_Pie.jpeg',
      price: 6.50,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: 'Tiramisu',
      description: 'Layers of coffee-soaked ladyfingers and mascarpone cream',
      imagePath: 'assets/menu/Tiramisu.jpeg',
      price: 7.00,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),

    // Drinks
    Food(
      name: 'Coffee',
      description: 'Hot or iced coffee',
      imagePath: 'assets/menu/Coffee.jpeg',
      price: 3.00,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: 'Tea',
      description: 'Hot or iced tea',
      imagePath: 'assets/menu/Tea.jpeg',
      price: 2.50,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: 'Soda',
      description: 'Coca-Cola, Pepsi, or Sprite',
      imagePath: 'assets/menu/Soda.jpeg',
      price: 2.00,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: 'Juice',
      description: 'Orange, apple, or cranberry juice',
      imagePath: 'assets/menu/Juice.jpeg',
      price: 3.00,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: 'Water',
      description: 'Bottled water',
      imagePath: 'assets/menu/Water.jpeg',
      price: 1.50,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),

  ];
    /*

Getters

*/

List <Food> get menu => _menu;
List <CartItem> get cart => _cart;

/*

Operations

*/

// user cart
final List<CartItem> _cart = [];

// add to cart
  void addtoCart(Food food,List<Addon> selectedAddon){
    //see if there is a cart item already with the same food and select addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if the food items are the same
      bool isSameFood = item.food == food;


      //check if the list of selected addons are the same
      bool isSameAddons= 
        const ListEquality().equals(item.selectedAddon, selectedAddon);

        return isSameFood && isSameAddons;
    });


      //if item already exist, increase it s quantity
    if (cartItem != null){
      cartItem.quantity++;
    }

    //otherwise add a new cart item to the cart
    else {
      _cart.add(CartItem(
        food: food, 
        selectedAddon: selectedAddon,
        ),
      );
    }
    notifyListeners();
  }

// remove to cart

void removeFromCart(CartItem cartItem){
  int cartIndex = _cart.indexOf(cartItem);

  if (cartIndex != 1){
    if (_cart[cartIndex].quantity > 1){
      _cart[cartIndex].quantity--;
    }else {
      _cart.removeAt(cartIndex);
    }
  }

  notifyListeners();
}

//get total price of cart
double getTotalPrice(){
  double total = 0.0;

  for (CartItem cartItem in _cart){
    double itemTotal = cartItem.food.price;

    for (Addon addon in cartItem.selectedAddon){
      itemTotal += addon.price;
    }

    total += itemTotal * cartItem.quantity;
  }

  return total;
}




// get total number of items in cart
int getTotalItemCount (){
  int totalItemCount = 0;


  for (CartItem cartItem in _cart) {
    totalItemCount += cartItem.quantity;
  }

  return totalItemCount;
} 



// clear cart
void clearCart(){
  _cart.clear();
  notifyListeners();
}


/*


Helpers


*/

//generate a receipt
String displayCartReceipt(){
  final receipt = StringBuffer();
  receipt.writeln("Here's your receipt.");
  receipt.writeln();


  //format the date to include up to second only
  String formattedDate = 
    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());


  receipt.writeln(formattedDate);
  receipt.writeln();
  receipt.writeln("----------");


  for (final CartItem in _cart){
    receipt.writeln(
      "${CartItem.quantity} x ${CartItem.food.name} - ${_formatPrice(CartItem.food.price)}");
    if (CartItem.selectedAddon.isNotEmpty){
      receipt
            .writeln("     Add-ons: ${_formatAddons(CartItem.selectedAddon)}");
    }
    receipt.writeln();
  }

  receipt.writeln("----------");
  receipt.writeln("");
  receipt.writeln("Total Items: ${getTotalItemCount()}");
  receipt.writeln("Total price: ${_formatPrice(getTotalPrice())}");

  return receipt.toString();
}



//format double value into money
String _formatPrice(double price){
  return "\$${price.toStringAsFixed(2)}";
}


//format list of addons into a string money
String _formatAddons (List<Addon> addons){
  return addons
    .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
    .join(",  ");
  }
}