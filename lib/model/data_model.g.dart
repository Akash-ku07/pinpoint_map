// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 0;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      E: fields[0] as String,
      N: fields[1] as String,
      Street: fields[2] as String,
      Camp: fields[3] as String,
      Zone: fields[4] as String,
      Country: fields[5] as String,
      Makthab: fields[6] as String,
      Category: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.E)
      ..writeByte(1)
      ..write(obj.N)
      ..writeByte(2)
      ..write(obj.Street)
      ..writeByte(3)
      ..write(obj.Camp)
      ..writeByte(4)
      ..write(obj.Zone)
      ..writeByte(5)
      ..write(obj.Country)
      ..writeByte(6)
      ..write(obj.Makthab)
      ..writeByte(7)
      ..write(obj.Category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
