// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String email;
  final String name;
  final String profilePic;
  final String uid;
  String token;

  UserModel({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] as String,
        name: map['name'] as String,
        profilePic: map['profilePic'] as String,
        uid: map['_id'] as String,
        token: '');
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profilePic': profilePic,
      '_id': uid,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) {
    try {
      Map<String, dynamic> map = json.decode(source);
      return UserModel.fromMap(map['user'] as Map<String, dynamic>)
        ..token = map['token'] as String;
    } catch (e) {
      // Handle parsing errors
      print("Error parsing UserModel from JSON: $e");
      // You can throw an exception or return a default UserModel instance here
      return UserModel(
        email: '',
        name: '',
        profilePic: '',
        uid: '',
        token: '',
      );
    }
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? uid,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}

final userStateProvider = StateProvider<UserModel?>((ref) {
  return null;
});
