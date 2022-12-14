import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:hive/hive.dart';

part 'user_cart.g.dart';

@HiveType(typeId: 3)
class UserCart extends HiveObject {
  @HiveField(0)
  List<HomeCatalogItem> cartList = [];
}
