import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu_item.dart';

// Events
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends RestaurantEvent {}

class SearchRestaurants extends RestaurantEvent {
  final String query;

  const SearchRestaurants({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterRestaurants extends RestaurantEvent {
  final String? cuisine;
  final double? minRating;
  final int? maxDeliveryTime;

  const FilterRestaurants({
    this.cuisine,
    this.minRating,
    this.maxDeliveryTime,
  });

  @override
  List<Object> get props => [cuisine ?? '', minRating ?? 0.0, maxDeliveryTime ?? 0];
}

class LoadRestaurantMenu extends RestaurantEvent {
  final String restaurantId;

  const LoadRestaurantMenu({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}

// States
abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantsLoaded({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantMenuLoaded extends RestaurantState {
  final Restaurant restaurant;
  final List<MenuItem> menuItems;

  const RestaurantMenuLoaded({
    required this.restaurant,
    required this.menuItems,
  });

  @override
  List<Object> get props => [restaurant, menuItems];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<FilterRestaurants>(_onFilterRestaurants);
    on<LoadRestaurantMenu>(_onLoadRestaurantMenu);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock restaurant data
      final restaurants = [
        const Restaurant(
          id: '1',
          name: 'Pizza Palace',
          description: 'Authentic Italian pizza with fresh ingredients',
          imageUrl: 'https://example.com/pizza.jpg',
          cuisine: 'Italian',
          rating: 4.5,
          reviewCount: 120,
          address: '123 Main St, City',
          deliveryTime: 30,
          deliveryFee: 2.99,
          isOpen: true,
          tags: ['Pizza', 'Italian', 'Fast Delivery'],
        ),
        const Restaurant(
          id: '2',
          name: 'Burger Barn',
          description: 'Juicy burgers and crispy fries',
          imageUrl: 'https://example.com/burger.jpg',
          cuisine: 'American',
          rating: 4.2,
          reviewCount: 89,
          address: '456 Oak Ave, City',
          deliveryTime: 25,
          deliveryFee: 1.99,
          isOpen: true,
          tags: ['Burgers', 'American', 'Quick Bites'],
        ),
        const Restaurant(
          id: '3',
          name: 'Sushi Zen',
          description: 'Fresh sushi and Japanese cuisine',
          imageUrl: 'https://example.com/sushi.jpg',
          cuisine: 'Japanese',
          rating: 4.8,
          reviewCount: 156,
          address: '789 Pine St, City',
          deliveryTime: 40,
          deliveryFee: 3.99,
          isOpen: true,
          tags: ['Sushi', 'Japanese', 'Premium'],
        ),
      ];
      
      emit(RestaurantsLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  Future<void> _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      // Simulate API call with search
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock filtered results based on search query
      final allRestaurants = [
        const Restaurant(
          id: '1',
          name: 'Pizza Palace',
          description: 'Authentic Italian pizza with fresh ingredients',
          imageUrl: 'https://example.com/pizza.jpg',
          cuisine: 'Italian',
          rating: 4.5,
          reviewCount: 120,
          address: '123 Main St, City',
          deliveryTime: 30,
          deliveryFee: 2.99,
          isOpen: true,
          tags: ['Pizza', 'Italian', 'Fast Delivery'],
        ),
        const Restaurant(
          id: '2',
          name: 'Burger Barn',
          description: 'Juicy burgers and crispy fries',
          imageUrl: 'https://example.com/burger.jpg',
          cuisine: 'American',
          rating: 4.2,
          reviewCount: 89,
          address: '456 Oak Ave, City',
          deliveryTime: 25,
          deliveryFee: 1.99,
          isOpen: true,
          tags: ['Burgers', 'American', 'Quick Bites'],
        ),
      ];
      
      final filteredRestaurants = allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(event.query.toLowerCase()) ||
              restaurant.cuisine.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      
      emit(RestaurantsLoaded(restaurants: filteredRestaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  Future<void> _onFilterRestaurants(
    FilterRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      // Simulate API call with filters
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock filtering logic
      final allRestaurants = [
        const Restaurant(
          id: '1',
          name: 'Pizza Palace',
          description: 'Authentic Italian pizza with fresh ingredients',
          imageUrl: 'https://example.com/pizza.jpg',
          cuisine: 'Italian',
          rating: 4.5,
          reviewCount: 120,
          address: '123 Main St, City',
          deliveryTime: 30,
          deliveryFee: 2.99,
          isOpen: true,
          tags: ['Pizza', 'Italian', 'Fast Delivery'],
        ),
      ];
      
      emit(RestaurantsLoaded(restaurants: allRestaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  Future<void> _onLoadRestaurantMenu(
    LoadRestaurantMenu event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock restaurant and menu data
      const restaurant = Restaurant(
        id: '1',
        name: 'Pizza Palace',
        description: 'Authentic Italian pizza with fresh ingredients',
        imageUrl: 'https://example.com/pizza.jpg',
        cuisine: 'Italian',
        rating: 4.5,
        reviewCount: 120,
        address: '123 Main St, City',
        deliveryTime: 30,
        deliveryFee: 2.99,
        isOpen: true,
        tags: ['Pizza', 'Italian', 'Fast Delivery'],
      );
      
      final menuItems = [
        const MenuItem(
          id: '1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce, mozzarella, and basil',
          price: 12.99,
          imageUrl: 'https://example.com/margherita.jpg',
          category: 'Pizza',
          isAvailable: true,
          customizations: {
            'Size': ['Small', 'Medium', 'Large'],
            'Crust': ['Thin', 'Thick', 'Stuffed'],
          },
        ),
        const MenuItem(
          id: '2',
          name: 'Pepperoni Pizza',
          description: 'Pizza with pepperoni and mozzarella cheese',
          price: 14.99,
          imageUrl: 'https://example.com/pepperoni.jpg',
          category: 'Pizza',
          isAvailable: true,
          customizations: {
            'Size': ['Small', 'Medium', 'Large'],
            'Crust': ['Thin', 'Thick', 'Stuffed'],
          },
        ),
        const MenuItem(
          id: '3',
          name: 'Caesar Salad',
          description: 'Fresh romaine lettuce with Caesar dressing and croutons',
          price: 8.99,
          imageUrl: 'https://example.com/caesar.jpg',
          category: 'Salads',
          isAvailable: true,
        ),
      ];
      
      emit(RestaurantMenuLoaded(restaurant: restaurant, menuItems: menuItems));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }
}

