import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

// Events
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final String menuItemId;
  final String name;
  final double price;
  final int quantity;
  final Map<String, String> customizations;
  final String? notes;

  const AddToCart({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
    this.customizations = const {},
    this.notes,
  });

  @override
  List<Object> get props => [menuItemId, name, price, quantity, customizations, notes ?? ''];
}

class RemoveFromCart extends CartEvent {
  final String menuItemId;

  const RemoveFromCart({required this.menuItemId});

  @override
  List<Object> get props => [menuItemId];
}

class UpdateCartItem extends CartEvent {
  final String menuItemId;
  final int quantity;

  const UpdateCartItem({required this.menuItemId, required this.quantity});

  @override
  List<Object> get props => [menuItemId, quantity];
}

class ClearCart extends CartEvent {}

// States
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  const CartUpdated({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  List<Object> get props => [items, subtotal, deliveryFee, tax, total];
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  final List<OrderItem> _items = [];
  static const double _deliveryFee = 2.99;
  static const double _taxRate = 0.08; // 8% tax

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.menuItemId == event.menuItemId &&
          _mapsEqual(item.customizations, event.customizations),
    );

    if (existingItemIndex != -1) {
      // Update existing item quantity
      final existingItem = _items[existingItemIndex];
      _items[existingItemIndex] = OrderItem(
        menuItemId: existingItem.menuItemId,
        name: existingItem.name,
        price: existingItem.price,
        quantity: existingItem.quantity + event.quantity,
        customizations: existingItem.customizations,
        notes: existingItem.notes,
      );
    } else {
      // Add new item
      _items.add(OrderItem(
        menuItemId: event.menuItemId,
        name: event.name,
        price: event.price,
        quantity: event.quantity,
        customizations: event.customizations,
        notes: event.notes,
      ));
    }

    _emitUpdatedCart(emit);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    _items.removeWhere((item) => item.menuItemId == event.menuItemId);
    _emitUpdatedCart(emit);
  }

  void _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) {
    final itemIndex = _items.indexWhere((item) => item.menuItemId == event.menuItemId);
    
    if (itemIndex != -1) {
      if (event.quantity <= 0) {
        _items.removeAt(itemIndex);
      } else {
        final item = _items[itemIndex];
        _items[itemIndex] = OrderItem(
          menuItemId: item.menuItemId,
          name: item.name,
          price: item.price,
          quantity: event.quantity,
          customizations: item.customizations,
          notes: item.notes,
        );
      }
    }

    _emitUpdatedCart(emit);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _items.clear();
    _emitUpdatedCart(emit);
  }

  void _emitUpdatedCart(Emitter<CartState> emit) {
    final subtotal = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final tax = subtotal * _taxRate;
    final total = subtotal + _deliveryFee + tax;

    emit(CartUpdated(
      items: List.from(_items),
      subtotal: subtotal,
      deliveryFee: _deliveryFee,
      tax: tax,
      total: total,
    ));
  }

  bool _mapsEqual(Map<String, String> map1, Map<String, String> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (map1[key] != map2[key]) return false;
    }
    return true;
  }
}

