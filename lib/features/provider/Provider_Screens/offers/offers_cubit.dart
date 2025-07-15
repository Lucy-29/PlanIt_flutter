import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Offer {
  final int id;
  final String description;
  final int price;
  final String imageUrl;

  Offer({
    required this.id,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
    );
  }
}
