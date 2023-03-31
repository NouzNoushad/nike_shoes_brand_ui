import 'package:flutter/material.dart';

class NikeBrands {
  final String brand;
  final String name;
  final String image;
  final double price;
  final Color background;

  NikeBrands({
    required this.brand,
    required this.name,
    required this.image,
    required this.price,
    required this.background,
  });
}

List<NikeBrands> nikeBrandsList = [
  NikeBrands(
    image: 'nike_jordan1.png',
    brand: 'Nike',
    name: 'Nike Jordan',
    price: 120.00,
    background: Colors.purple,
  ),
  NikeBrands(
    image: 'nike_jordan2.png',
    brand: 'Nike',
    name: 'Nike Jordan',
    price: 140.00,
    background: Colors.pink,
  ),
  NikeBrands(
    image: 'nike_jordan3.png',
    brand: 'Nike',
    name: 'Nike Jordan',
    price: 130.00,
    background: Colors.grey,
  ),
];
