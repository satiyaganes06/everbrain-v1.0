// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_password_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaultPasswordAdapter extends TypeAdapter<VaultPassword> {
  @override
  final int typeId = 1;

  @override
  VaultPassword read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VaultPassword(
      valuePasswordKYS: fields[0] as String,
      vaultPassword: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VaultPassword obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.valuePasswordKYS)
      ..writeByte(1)
      ..write(obj.vaultPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaultPasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
