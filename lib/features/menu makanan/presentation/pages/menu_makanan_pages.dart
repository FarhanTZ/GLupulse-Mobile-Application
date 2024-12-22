import 'package:finpro/features/home/component/my_deskripsi_box.dart';
import 'package:finpro/features/menu%20makanan/presentation/Components/my_food_tile.dart';
import 'package:finpro/features/menu%20makanan/presentation/pages/food_pages.dart';
import 'package:provider/provider.dart';
import 'package:finpro/features/menu%20makanan/presentation/Components/my_tab_bar.dart';
import 'package:finpro/features/menu%20makanan/presentation/Components/my_current_location.dart';
import 'package:finpro/features/menu%20makanan/presentation/Components/my_silver_app_bar.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/food.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';
import 'package:flutter/material.dart';

class MenuMakananPage extends StatefulWidget {
  const MenuMakananPage({super.key});

  @override
  State<MenuMakananPage> createState() => _MenuMakananPageState();
}

class _MenuMakananPageState extends State<MenuMakananPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: FoodCategory.values.length, vsync: this);
  }

@override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//sort out and return a list of food items that belong to a specific category
List<Food> _fillterMenuByCategory(FoodCategory category, List<Food> fullMenu){
  return fullMenu.where((food) => food.category == category).toList();
}


// return list of food in give category
List<Widget> getFoodInThisCatagory(List<Food> fullMenu){
  return FoodCategory.values.map((category) {



    //get category menu
    List<Food> categoryMenu = _fillterMenuByCategory(category, fullMenu);


    return ListView.builder(
      itemCount: categoryMenu. length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        //get individual food
        final food = categoryMenu[index];

        //return food tile UI
        return FoodTile(
          food: food, 
          onTap: () => Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => FoodPages(food: food),
              ),
            ),
          );

      },
      );
  }).toList();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxisScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Colors.grey.shade100,
                  ),



                // My Current location
                const MyCurrentLocation(),



                //deskripsi box
                const MyDeskripsiBox(),
              ],
            ),
            ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCatagory(restaurant.menu),
        ),
        ),
      )
    ); 
  }
}