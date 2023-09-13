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

  @HiveField(2)
  final String sourceName;

  @HiveField(9)
  final String sourceImageUrl;

  @HiveField(3)
  final String vaultName;

  @HiveField(4)
  final String vaultPassword;

  @HiveField(5)
  final String hintPassword;

  @HiveField(6)
  final String vaultCategory;

  @HiveField(7)
  final bool isFavourite;

  @HiveField(8)
  final bool isMPUnlock;

  Vault({
    required this.userID,
    required this.vaultID,
    required this.sourceName,
    required this.sourceImageUrl,
    required this.vaultName,
    required this.vaultPassword,
    required this.hintPassword,
    required this.vaultCategory,
    required this.isFavourite,
    required this.isMPUnlock,
  });

  Vault copyWith({
    String? userID,
    String? vaultID,
    String? sourceName,
    String? sourceImageUrl,
    String? vaultName,
    String? vaultPassword,
    String? hintPassword,
    String? vaultCategory,
    bool? isFavourite,
    bool? isMPUnlock,
  }) {
    return Vault(
      userID: userID ?? this.userID,
      vaultID: vaultID ?? this.vaultID,
      sourceName: sourceName ?? this.sourceName,
      sourceImageUrl: sourceImageUrl ?? this.sourceImageUrl,
      vaultName: vaultName ?? this.vaultName,
      vaultPassword: vaultPassword ?? this.vaultPassword,
      hintPassword: hintPassword ?? this.hintPassword,
      vaultCategory: vaultCategory ?? this.vaultCategory,
      isFavourite: isFavourite ?? this.isFavourite,
      isMPUnlock: isMPUnlock ?? this.isMPUnlock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'vaultID': vaultID,
      'sourceName': sourceName,
      'sourceImageUrl': sourceImageUrl,
      'vaultName': vaultName,
      'vaultPassword': vaultPassword,
      'hintPassword': hintPassword,
      'vaultCategory': vaultCategory,
      'isFavourite': isFavourite,
      'isMPUnlock': isMPUnlock,
    };
  }

  factory Vault.fromMap(Map<String, dynamic> map) {
    return Vault(
      userID: map['userID'] as String,
      vaultID: map['vaultID'] as String,
      sourceName: map['sourceName'] as String,
      sourceImageUrl: map['sourceImageUrl'] as String,
      vaultName: map['vaultName'] as String,
      vaultPassword: map['vaultPassword'] as String,
      hintPassword: map['hintPassword'] as String,
      vaultCategory: map['vaultCategory'] as String,
      isFavourite: map['isFavourite'] as bool,
      isMPUnlock: map['isMPUnlock'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vault.fromJson(String source) => Vault.fromMap(json.decode(source) as Map<String, dynamic>);

}
