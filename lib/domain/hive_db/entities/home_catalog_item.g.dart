// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_catalog_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeCatalogItemAdapter extends TypeAdapter<HomeCatalogItem> {
  @override
  final int typeId = 0;

  @override
  HomeCatalogItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeCatalogItem(
      id: fields[0] as int,
      name: fields[1] as String,
      cost: fields[2] as double,
      imageNames: (fields[3] as Map).cast<String, String>(),
      detailsText: fields[4] as String,
      rating: fields[5] as double,
      countReviews: fields[6] as int,
      maxQuantity: fields[8] as int,
      selectedColor: fields[9] as String,
    )
      ..selectedQuantity = fields[7] == null ? 1 : fields[7] as int
      ..isFavorite = fields[10] as bool;
  }

  @override
  void write(BinaryWriter writer, HomeCatalogItem obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.imageNames)
      ..writeByte(4)
      ..write(obj.detailsText)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.countReviews)
      ..writeByte(7)
      ..write(obj.selectedQuantity)
      ..writeByte(8)
      ..write(obj.maxQuantity)
      ..writeByte(9)
      ..write(obj.selectedColor)
      ..writeByte(10)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeCatalogItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
