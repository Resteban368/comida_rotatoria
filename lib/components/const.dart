import 'package:comida_rotatoria/models/food_models.dart';
import 'package:flutter/material.dart';

List<FoodDetail> foodList = [

  FoodDetail(
    img1: "assets/plate1a.png",
    img2: "assets/plate1b.png",
    name: "Chilly and garlic lamb",
    description: "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur." ,
    size: "Medium",
    price: 5.99,
    rating: 4.5,
    time: 30,
    cantidad: 2,
    category: "Mexican",
    colorScheme: const ColorScheme.dark(
        background: Color(0xff223242),
      ),
  ),
  FoodDetail(
    img1: "assets/plate2a.png",
    img2: "assets/plate2b.png",
    name: "Pizza margarita",
    description: "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur." ,
    size: "Small",
    price: 5.99,
    rating: 4.1,
    time: 25,
    cantidad: 1,
    category: "Italian",
     colorScheme: const ColorScheme.light(),
  ),
  FoodDetail(
    img1: "assets/plate3a.png",
    img2: "assets/plate3b.png",
    name: "Veggie paradise and Extravanza",
    description: "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur." ,
    size: "Medium",
    price: 5.99,
    rating: 4.3,
    time: 15,
    cantidad: 2,
    category: "Veggie",
     colorScheme: const ColorScheme.dark(
        background: Color(0xff223242),
      ),
  ),




];