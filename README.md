# OnlyEats Flutter Application

A comprehensive food delivery mobile application built with Flutter, featuring restaurant browsing, menu exploration, order management, and user authentication.

## Project Overview

OnlyEats is a modern food delivery platform that connects users with local restaurants through an intuitive mobile interface. The application provides a seamless ordering experience with features including restaurant discovery, menu browsing, cart management, and order tracking.

## Features

### Core Functionality
- **User Authentication**: Secure registration and login system
- **Restaurant Discovery**: Browse and search local restaurants
- **Menu Exploration**: Detailed menu browsing with customization options
- **Order Management**: Complete ordering workflow from cart to delivery
- **User Profiles**: Account management and order history

### Technical Highlights
- **Clean Architecture**: Separation of concerns across presentation, domain, and data layers
- **BLoC Pattern**: Reactive state management for predictable app behavior
- **Responsive Design**: Optimized for various screen sizes and orientations
- **Type Safety**: Comprehensive data models with validation
- **Error Handling**: Graceful error management and user feedback

## Project Structure

```
lib/
├── core/
│   ├── network/          # API client and network utilities
│   ├── theme/            # App theming and styling
│   └── utils/            # Utility functions and helpers
├── features/
│   ├── auth/             # Authentication feature
│   │   ├── data/         # Data models and repositories
│   │   ├── domain/       # Business entities and use cases
│   │   └── presentation/ # UI screens, widgets, and BLoCs
│   ├── restaurant/       # Restaurant browsing and menu
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── order/            # Order management and cart
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── profile/          # User profile management
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart             # Application entry point
```

## Getting Started

### Prerequisites

- Flutter SDK 3.24.5 or later
- Dart SDK 3.5.0 or later
- Android Studio / VS Code with Flutter extensions
- iOS development: Xcode (for iOS builds)
- Android development: Android SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd only_eats
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Dependencies

The project uses the following key dependencies:

- `flutter_bloc: ^8.1.3` - State management
- `http: ^1.1.0` - HTTP client for API calls
- `equatable: ^2.0.5` - Value equality for data models

## Architecture

### Clean Architecture Layers

1. **Presentation Layer**
   - UI screens and widgets
   - BLoC state management
   - User interaction handling

2. **Domain Layer**
   - Business entities
   - Use cases and business logic
   - Repository interfaces

3. **Data Layer**
   - Data models and DTOs
   - Repository implementations
   - API clients and data sources

### State Management

The application uses the BLoC (Business Logic Component) pattern for state management:

- **AuthBloc**: Handles user authentication states
- **RestaurantBloc**: Manages restaurant data and search
- **CartBloc**: Oversees shopping cart operations
- **OrderBloc**: Coordinates order placement and tracking

## API Integration

The application is designed to integrate with a RESTful backend API with the following endpoints:

### Authentication
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `GET /auth/profile` - Get user profile

### Restaurants
- `GET /restaurants` - List restaurants with filtering
- `GET /restaurants/{id}` - Get restaurant details
- `GET /restaurants/{id}/menu` - Get restaurant menu
- `GET /restaurants/search` - Search restaurants

### Orders
- `POST /orders` - Create new order
- `GET /orders` - Get user order history
- `GET /orders/{id}` - Get order details
- `PUT /orders/{id}/cancel` - Cancel order

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Structure

- **Unit Tests**: Business logic and data model testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end workflow testing

## Building for Production

### Android Build

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Build

```bash
# Build for iOS
flutter build ios --release
```

## Deployment

### Android Deployment
1. Build the app bundle: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Complete store listing and compliance requirements
4. Submit for review

### iOS Deployment
1. Build for iOS: `flutter build ios --release`
2. Archive in Xcode
3. Upload to App Store Connect
4. Complete app metadata and submit for review

## Contributing

### Development Guidelines

1. **Code Style**: Follow Dart style guidelines
2. **Architecture**: Maintain clean architecture principles
3. **Testing**: Write tests for new features
4. **Documentation**: Update documentation for changes

### Git Workflow

1. Create feature branches from `main`
2. Make atomic commits with clear messages
3. Submit pull requests for review
4. Ensure all tests pass before merging

## Documentation

- **Technical Documentation**: `OnlyEats_Technical_Documentation.md`
- **User Guide**: `OnlyEats_User_Guide.md`
- **API Documentation**: Included in technical documentation
- **Architecture Overview**: `app_architecture.md`

## Support

For technical support or questions:
- Review the documentation files
- Check the troubleshooting section in the user guide
- Contact the development team

## License

This project is proprietary software. All rights reserved.

## Version History

- **v1.0.0** - Initial release with core functionality
  - User authentication
  - Restaurant browsing
  - Order management
  - Basic user profiles

---

**Built with ❤️ using Flutter**

