import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});
  @override
  State<QuestScreen> createState() => _QuestScreenState();
}
class _QuestScreenState extends State<QuestScreen> {

  @override
  Widget build(BuildContext context) {
    return ListQuest();
  }
}
