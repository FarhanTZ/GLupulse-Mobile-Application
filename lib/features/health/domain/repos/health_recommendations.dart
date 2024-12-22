import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';

import '../../../menu makanan/presentation/models/food.dart';

class HealthRecommendation {
  final Restaurant restaurant;

  HealthRecommendation(this.restaurant);

  List<Food> getRecommendedFood(double healthScore) {
    List<Food> recommendedFood = [];

    if (healthScore >= 80) {
      // High Health Score: Recommend lighter, healthy options like salads and drinks.
      recommendedFood = restaurant.menu.where((food) {
        return food.category == FoodCategory.salads ||
            food.category == FoodCategory.drinks;
      }).toList();
    } else if (healthScore >= 60) {
      // Medium Health Score: Recommend balanced meals with proteins and sides.
      recommendedFood = restaurant.menu.where((food) {
        return food.category == FoodCategory.main ||
            food.category == FoodCategory.sides;
      }).toList();
    } else {
      // Low Health Score: Recommend low-calorie and fiber-rich options.
      recommendedFood = restaurant.menu.where((food) {
        return food.category == FoodCategory.main &&
            (food.name == 'Vegetarian Curry' || food.name == 'Quinoa Salad');
      }).toList();
    }

    return recommendedFood;
  }
}
