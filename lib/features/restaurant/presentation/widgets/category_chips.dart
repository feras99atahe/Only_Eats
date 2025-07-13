import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restaurant_bloc.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String? selectedCategory;

  final List<String> categories = [
    'All',
    'Italian',
    'American',
    'Japanese',
    'Chinese',
    'Mexican',
    'Indian',
    'Thai',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category || 
                           (selectedCategory == null && category == 'All');

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (category == 'All') {
                    selectedCategory = null;
                    context.read<RestaurantBloc>().add(LoadRestaurants());
                  } else {
                    selectedCategory = selected ? category : null;
                    if (selected) {
                      context.read<RestaurantBloc>().add(
                        FilterRestaurants(cuisine: category),
                      );
                    } else {
                      context.read<RestaurantBloc>().add(LoadRestaurants());
                    }
                  }
                });
              },
              selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
              checkmarkColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}

