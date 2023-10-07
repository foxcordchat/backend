import 'package:foxcord_common/src/persistence/entity/base/base.dart';
import 'package:stormberry/stormberry.dart';

part 'user.schema.dart';

@Model(tableName: 'users')
abstract class UserEntity extends BaseEntity {}
