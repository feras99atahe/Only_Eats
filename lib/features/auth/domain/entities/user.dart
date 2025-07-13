import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final List<String> addresses;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.addresses = const [],
  });

  @override
  List<Object?> get props => [id, name, email, phoneNumber, profileImageUrl, addresses];
}

