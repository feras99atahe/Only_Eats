import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final List<String> allergens;
  final Map<String, List<String>> customizations; // e.g., {"Size": ["Small", "Medium", "Large"]}

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
    this.allergens = const [],
    this.customizations = const {},
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        isAvailable,
        allergens,
        customizations,
      ];
}

