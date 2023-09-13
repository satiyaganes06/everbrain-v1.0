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
      sourceName: fields[2] as String,
      sourceImageUrl: fields[9] as String,
      vaultName: fields[3] as String,
      vaultPassword: fields[4] as String,
      hintPassword: fields[5] as String,
      vaultCategory: fields[6] as String,
      isFavourite: fields[7] as bool,
      isMPUnlock: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Vault obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.vaultID)
      ..writeByte(2)
      ..write(obj.sourceName)
      ..writeByte(9)
      ..write(obj.sourceImageUrl)
      ..writeByte(3)
      ..write(obj.vaultName)
      ..writeByte(4)
      ..write(obj.vaultPassword)
      ..writeByte(5)
      ..write(obj.hintPassword)
      ..writeByte(6)
      ..write(obj.vaultCategory)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.isMPUnlock);
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
