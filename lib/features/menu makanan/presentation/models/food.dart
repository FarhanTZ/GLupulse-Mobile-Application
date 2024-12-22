// food item
class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;

  // Tambahkan properti untuk menentukan apakah makanan ini rendah gula, tinggi serat, atau rendah garam
  final bool isLowSugar;
  final bool isHighFiber;
  final bool isLowSalt;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
    this.isLowSugar = false,    // Properti untuk rendah gula
    this.isHighFiber = false,   // Properti untuk tinggi serat
    this.isLowSalt = false,     // Properti untuk rendah garam
  });
}

// food category
enum FoodCategory {
  main,
  salads,
  sides,
  desserts,
  drinks,
}

// food addons
class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
