import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
  }) => ProfileModel(
    id: id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );

  @override
  List<Object?> get props => [id, name, email, phone, avatarUrl];
}
