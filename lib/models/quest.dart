import 'package:isar/isar.dart';

part 'quest.g.dart';

@Collection()
class Quest{
  Id id = Isar.autoIncrement;
  late String titolo;
  late String descrizione;
  late int ricompensa;
  @Index()
  late String email;
  late String color;
  late String importanza;
  late String qcolor;
}