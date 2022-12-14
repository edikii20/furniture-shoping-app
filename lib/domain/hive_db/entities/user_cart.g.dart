// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCartAdapter extends TypeAdapter<UserCart> {
  @override
  final int typeId = 3;

  @override
  UserCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCart()..cartList = (fields[0] as List).cast<HomeCatalogItem>();
  }

  @override
  void write(BinaryWriter writer, UserCart obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cartList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
