import 'package:hive/hive.dart';

part "data_model.g.dart";

@HiveType(typeId: 0)
class DataModel {
  @HiveField(0)
  final String E;

  @HiveField(1)
  final String N;

  @HiveField(2)
  final String Street;

  @HiveField(3)
  final String Camp;

  @HiveField(4)
  final String Zone;

  @HiveField(5)
  final String Country;

  @HiveField(6)
  final String Makthab;

  @HiveField(7)
  final String Category;

  DataModel({required this.E, required this.N, required this.Street, required this.Camp, required this.Zone, required this.Country,
    required this.Makthab, required this.Category});
}