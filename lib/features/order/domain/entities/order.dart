import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

class OrderItem extends Equatable {
  final String menuItemId;
  final String name;
  final double price;
  final int quantity;
  final Map<String, String> customizations;
  final String? notes;

  const OrderItem({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
    this.customizations = const {},
    this.notes,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [menuItemId, name, price, quantity, customizations, notes];
}

class Order extends Equatable {
  final String id;
  final String userId;
  final String restaurantId;
  final String restaurantName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String deliveryAddress;
  final String? notes;

  const Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDeliveryTime,
    required this.deliveryAddress,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        restaurantId,
        restaurantName,
        items,
        subtotal,
        deliveryFee,
        tax,
        total,
        status,
        createdAt,
        estimatedDeliveryTime,
        deliveryAddress,
        notes,
      ];
}

