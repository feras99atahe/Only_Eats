import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

// Events
abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final String restaurantId;
  final String restaurantName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String deliveryAddress;
  final String? notes;

  const PlaceOrder({
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.deliveryAddress,
    this.notes,
  });

  @override
  List<Object> get props => [
        restaurantId,
        restaurantName,
        items,
        subtotal,
        deliveryFee,
        tax,
        total,
        deliveryAddress,
        notes ?? '',
      ];
}

class LoadOrderHistory extends OrderEvent {}

class TrackOrder extends OrderEvent {
  final String orderId;

  const TrackOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class CancelOrder extends OrderEvent {
  final String orderId;

  const CancelOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

// States
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderPlaced extends OrderState {
  final Order order;

  const OrderPlaced({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderHistoryLoaded extends OrderState {
  final List<Order> orders;

  const OrderHistoryLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderTracking extends OrderState {
  final Order order;

  const OrderTracking({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final List<Order> _orderHistory = [];

  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<LoadOrderHistory>(_onLoadOrderHistory);
    on<TrackOrder>(_onTrackOrder);
    on<CancelOrder>(_onCancelOrder);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: '1', // Mock user ID
        restaurantId: event.restaurantId,
        restaurantName: event.restaurantName,
        items: event.items,
        subtotal: event.subtotal,
        deliveryFee: event.deliveryFee,
        tax: event.tax,
        total: event.total,
        status: OrderStatus.confirmed,
        createdAt: DateTime.now(),
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
        deliveryAddress: event.deliveryAddress,
        notes: event.notes,
      );

      _orderHistory.insert(0, order);
      emit(OrderPlaced(order: order));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onLoadOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Add some mock orders if history is empty
      if (_orderHistory.isEmpty) {
        _orderHistory.addAll([
          Order(
            id: '1',
            userId: '1',
            restaurantId: '1',
            restaurantName: 'Pizza Palace',
            items: const [
              OrderItem(
                menuItemId: '1',
                name: 'Margherita Pizza',
                price: 12.99,
                quantity: 1,
              ),
            ],
            subtotal: 12.99,
            deliveryFee: 2.99,
            tax: 1.04,
            total: 17.02,
            status: OrderStatus.delivered,
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
            deliveryAddress: '123 Main St, City',
          ),
          Order(
            id: '2',
            userId: '1',
            restaurantId: '2',
            restaurantName: 'Burger Barn',
            items: const [
              OrderItem(
                menuItemId: '4',
                name: 'Classic Burger',
                price: 9.99,
                quantity: 2,
              ),
            ],
            subtotal: 19.98,
            deliveryFee: 1.99,
            tax: 1.60,
            total: 23.57,
            status: OrderStatus.delivered,
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
            deliveryAddress: '123 Main St, City',
          ),
        ]);
      }

      emit(OrderHistoryLoaded(orders: List.from(_orderHistory)));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onTrackOrder(TrackOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final order = _orderHistory.firstWhere(
        (order) => order.id == event.orderId,
        orElse: () => throw Exception('Order not found'),
      );

      emit(OrderTracking(order: order));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  Future<void> _onCancelOrder(CancelOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final orderIndex = _orderHistory.indexWhere((order) => order.id == event.orderId);
      if (orderIndex != -1) {
        final order = _orderHistory[orderIndex];
        final cancelledOrder = Order(
          id: order.id,
          userId: order.userId,
          restaurantId: order.restaurantId,
          restaurantName: order.restaurantName,
          items: order.items,
          subtotal: order.subtotal,
          deliveryFee: order.deliveryFee,
          tax: order.tax,
          total: order.total,
          status: OrderStatus.cancelled,
          createdAt: order.createdAt,
          estimatedDeliveryTime: order.estimatedDeliveryTime,
          deliveryAddress: order.deliveryAddress,
          notes: order.notes,
        );

        _orderHistory[orderIndex] = cancelledOrder;
        emit(OrderTracking(order: cancelledOrder));
      } else {
        emit(const OrderError(message: 'Order not found'));
      }
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}

