import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.cuisine,
    required super.rating,
    required super.reviewCount,
    required super.address,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.isOpen,
    super.tags,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      cuisine: json['cuisine'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      address: json['address'] as String,
      deliveryTime: json['deliveryTime'] as int,
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      isOpen: json['isOpen'] as bool,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'cuisine': cuisine,
      'rating': rating,
      'reviewCount': reviewCount,
      'address': address,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'isOpen': isOpen,
      'tags': tags,
    };
  }
}

