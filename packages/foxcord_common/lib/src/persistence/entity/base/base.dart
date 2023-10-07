import 'package:stormberry/stormberry.dart';

abstract class BaseEntity {
  @PrimaryKey()
  String get id;
}
