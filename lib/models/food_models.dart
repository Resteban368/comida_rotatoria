import 'package:flutter/material.dart';

class FoodDetail {
  String? img1;
  String? img2;
  String? name;
  String? description;
  String? size;
  double? price;
  double? rating;
  int? time;
  int? cantidad;
  String? category;
  ColorScheme? colorScheme;

  FoodDetail({
    this.img1,
    this.img2,
    this.name,
    this.description,
    this.size,
    this.price,
    this.rating,
    this.time,
    this.cantidad,
    this.category,
    this.colorScheme,
  });

  @override
  String toString() {
    return 'FoodDetail{img1: $img1,img2: $img2, name: $name, description: $description, size: $size, price: $price, rating: $rating, time: $time, cantidad: $cantidad, category: $category}';
  }

  factory FoodDetail.fromJson(Map<String, dynamic> json) => FoodDetail(
        img1: json["img1"],
        img2: json["img2"],
        name: json["name"],
        description: json["description"],
        size: json["size"],
        price: json["price"],
        rating: json["rating"],
        time: json["time"],
        cantidad: json["cantidad"],
        category: json["category"],
        colorScheme: json["colorScheme"],

      );

  Map<String, dynamic> toJson() => {
        "img1": img1,
        "img2": img2,
        "name": name,
        "description": description,
        "size": size,
        "price": price,
        "rating": rating,
        "time": time,
        "cantidad": cantidad,
        "category": category,
        "colorScheme": colorScheme,
      };
}
