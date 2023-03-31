import 'package:flutter/material.dart';

class MoreBrands {
  final String name;
  final String image;
  final double price;

  MoreBrands({
    required this.name,
    required this.image,
    required this.price,
  });
}

List<MoreBrands> moreBrandsList = [
  MoreBrands(
    image: 'nike_carter.png',
    name: 'Nike Carter',
    price: 180.00,
  ),
  MoreBrands(
    image: 'nike_air.png',
    name: 'Nike Air',
    price: 160.00,
  ),
  MoreBrands(
    image: 'nike_cosmic.png',
    name: 'Nike Cosmic',
    price: 140.00,
  ),
];
