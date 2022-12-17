// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:furniture_shoping_app/domain/hive_db/entities/user.dart';

part 'session.g.dart';

@HiveType(typeId: 5)
class Session extends HiveObject {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final User user;

  Session({
    required this.token,
    required this.user,
  });
}
