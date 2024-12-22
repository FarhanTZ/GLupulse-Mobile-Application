import 'package:finpro/features/menu%20makanan/presentation/models/food.dart';


class CartItem {
  Food food;
  List <Addon> selectedAddon;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddon,
    this.quantity = 1,
  });


  double get totalPrice{
    double addonsPrice = selectedAddon.fold(0, (sum,Addon) => sum + Addon.price);
    return (food.price + addonsPrice) * quantity;
  }
}