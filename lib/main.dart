import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'features/order/presentation/bloc/cart_bloc.dart';
import 'features/order/presentation/bloc/order_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/restaurant/presentation/screens/home_screen.dart';

void main() {
  runApp(const OnlyEatsApp());
}

class OnlyEatsApp extends StatelessWidget {
  const OnlyEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckAuthStatus())),
        BlocProvider(create: (context) => RestaurantBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => OrderBloc()),
      ],
      child: MaterialApp(
        title: 'OnlyEats',
        theme: AppTheme.lightTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

