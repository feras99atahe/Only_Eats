import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String cuisine;
  final double rating;
  final int reviewCount;
  final String address;
  final int deliveryTime; // in minutes
  final double deliveryFee;
  final bool isOpen;
  final List<String> tags;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    this.tags = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        cuisine,
        rating,
        reviewCount,
        address,
        deliveryTime,
        deliveryFee,
        isOpen,
        tags,
      ];
}

