import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note{
  Id id = Isar.autoIncrement;
  late String titolo;
  late String descrizione;
  late int ricompensa;
}