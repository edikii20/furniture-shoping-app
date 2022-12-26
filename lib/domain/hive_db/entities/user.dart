import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String image;
  @HiveField(4)
  List<HomeCatalogItem> cartList;
  @HiveField(5)
  HiveList<HomeCatalogItem> favoriteList;

  //TODO: Добавить списки my orders, shipping address, payment method, my rewiews

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.cartList,
    required this.favoriteList,
  });
}
