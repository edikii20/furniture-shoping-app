import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String image;
  //Добавить id
  //Добавить корзину и список любимых
  //Добавить списки my orders, shipping address, payment method, my rewiews

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });
}
