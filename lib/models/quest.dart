import 'package:isar/isar.dart';

part 'quest.g.dart';

@Collection()
class Quest{
  Id id = Isar.autoIncrement;
  late String title;
  late String description;
  late int points;
  @Index()
  late String email;
  late String color;
  late String importance;
  late bool infinity;
  late int countExecutions;
}