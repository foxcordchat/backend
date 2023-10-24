import 'package:stormberry/stormberry.dart';

part 'user.schema.dart';

@Model(tableName: 'users')
abstract class UserEntity {
  @PrimaryKey()
  String get id;
}
