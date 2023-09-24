// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaultAdapter extends TypeAdapter<Vault> {
  @override
  final int typeId = 0;

  @override
  Vault read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vault(
      userID: fields[0] as String,
      vaultID: fields[1] as String,
      username: fields[12] as String,
      websiteImageUrl: fields[13] as String,
      vaultName: fields[3] as String,
      websiteUrl: fields[10] as String,
      vaultCategory: fields[6] as String,
      isFavourite: fields[7] as bool,
      isBiometricUnlock: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Vault obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.vaultID)
      ..writeByte(12)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.vaultName)
      ..writeByte(10)
      ..write(obj.websiteUrl)
      ..writeByte(13)
      ..write(obj.websiteImageUrl)
      ..writeByte(6)
      ..write(obj.vaultCategory)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(11)
      ..write(obj.isBiometricUnlock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
