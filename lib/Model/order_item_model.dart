import 'package:flutter/material.dart';

class OrderItemModel {
  final String? name;
  final int? quantity;
  final double? price;
  final VoidCallback onPressedDecrement;
  final VoidCallback onPressedIncrement;
  OrderItemModel({
    required this.onPressedDecrement,
    required this.onPressedIncrement,
    required this.name,
    required this.quantity,
    required this.price,
  });
}