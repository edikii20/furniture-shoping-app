import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String image;

  //TODO: Добавить корзину и список любимых
  //TODO: Добавить списки my orders, shipping address, payment method, my rewiews

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });
}
