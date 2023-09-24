// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'vault_model.g.dart';

@HiveType(typeId: 0)
class Vault extends HiveObject {
  @HiveField(0)
  final String userID;

  @HiveField(1)
  final String vaultID;

  @HiveField(12)
  final String username;
  
  @HiveField(3)
  final String vaultName;

  @HiveField(10)
  final String websiteUrl;

  @HiveField(13)
  final String websiteImageUrl;

  @HiveField(6)
  final String vaultCategory;

  @HiveField(7)
  final bool isFavourite;

  @HiveField(11)
  final bool isBiometricUnlock;

  Vault({
    required this.userID,
    required this.vaultID,
    required this.username,
    required this.websiteImageUrl,
    required this.vaultName,
    required this.websiteUrl,
    required this.vaultCategory,
    required this.isFavourite,
    required this.isBiometricUnlock,
  });

  Vault copyWith({
    String? userID,
    String? vaultID,
    String? username,
    String? websiteImageUrl,
    String? vaultName,
    String? websiteUrl,
    String? vaultCategory,
    bool? isFavourite,
    bool? isBiometricUnlock,
  }) {
    return Vault(
      userID: userID ?? this.userID,
      vaultID: vaultID ?? this.vaultID,
      username: username ?? this.username,
      websiteImageUrl: websiteImageUrl ?? this.websiteImageUrl,
      vaultName: vaultName ?? this.vaultName,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      vaultCategory: vaultCategory ?? this.vaultCategory,
      isFavourite: isFavourite ?? this.isFavourite,
      isBiometricUnlock: isBiometricUnlock ?? this.isBiometricUnlock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'vaultID': vaultID,
      'username': username,
      'websiteImageUrl': websiteImageUrl,
      'vaultName': vaultName,
      'websiteUrl': websiteUrl,
      'vaultCategory': vaultCategory,
      'isFavourite': isFavourite,
      'isBiometricUnlock': isBiometricUnlock,
    };
  }

  factory Vault.fromMap(Map<String, dynamic> map) {
    return Vault(
      userID: map['userID'] as String,
      vaultID: map['vaultID'] as String,
      username: map['username'] as String,
      websiteImageUrl: map['websiteImageUrl'] as String,
      vaultName: map['vaultName'] as String,
      websiteUrl: map['websiteUrl'] as String,
      vaultCategory: map['vaultCategory'] as String,
      isFavourite: map['isFavourite'] as bool,
      isBiometricUnlock: map['isBiometricUnlock'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vault.fromJson(String source) => Vault.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vault(userID: $userID, vaultID: $vaultID, username: $username, websiteImageUrl: $websiteImageUrl, vaultName: $vaultName, websiteUrl: $websiteUrl, vaultCategory: $vaultCategory, isFavourite: $isFavourite, isBiometricUnlock: $isBiometricUnlock)';
   
  }

}
