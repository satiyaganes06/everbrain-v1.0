// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'vault_password_model.g.dart';

@HiveType(typeId: 1)
class VaultPassword extends HiveObject {
  @HiveField(0)
  final String valuePasswordKYS;

  @HiveField(1)
  final String vaultPassword;

  VaultPassword({
    required this.valuePasswordKYS,
    required this.vaultPassword,
  });


  VaultPassword copyWith({
    String? valuePasswordKYS,
    String? vaultPassword,
  }) {
    return VaultPassword(
      valuePasswordKYS: valuePasswordKYS ?? this.valuePasswordKYS,
      vaultPassword: vaultPassword ?? this.vaultPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valuePasswordKYS': valuePasswordKYS,
      'vaultPassword': vaultPassword,
    };
  }

  factory VaultPassword.fromMap(Map<String, dynamic> map) {
    return VaultPassword(
      valuePasswordKYS: map['valuePasswordKYS'] as String,
      vaultPassword: map['vaultPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VaultPassword.fromJson(String source) => VaultPassword.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VaultPassword(valuePasswordKYS: $valuePasswordKYS, vaultPassword: $vaultPassword)';

  @override
  bool operator ==(covariant VaultPassword other) {
    if (identical(this, other)) return true;
  
    return 
      other.valuePasswordKYS == valuePasswordKYS &&
      other.vaultPassword == vaultPassword;
  }

  @override
  int get hashCode => valuePasswordKYS.hashCode ^ vaultPassword.hashCode;
}
