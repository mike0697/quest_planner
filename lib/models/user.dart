import 'package:isar/isar.dart';

part 'user.g.dart';
@collection
class User{
  Id id = Isar.autoIncrement;
  late String nome;
  late int livello;
  late int punti;

}