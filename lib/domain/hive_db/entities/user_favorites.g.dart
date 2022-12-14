// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_favorites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserFavoritesAdapter extends TypeAdapter<UserFavorites> {
  @override
  final int typeId = 2;

  @override
  UserFavorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserFavorites()
      ..favoriteList = (fields[0] as HiveList).castHiveList();
  }

  @override
  void write(BinaryWriter writer, UserFavorites obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favoriteList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFavoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
