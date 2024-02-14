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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quest Planner'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.all(10),
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(child: Text('Tutti', style: TextStyle(fontSize: 22),)),
              Tab(child: Text('Urgente', style: TextStyle(fontSize: 22),)),
              Tab(child: Text('Prioritario', style: TextStyle(fontSize: 22),)),
              Tab(child: Text('Secondario', style: TextStyle(fontSize: 22),)),
              Tab(child: Text('Inbox', style: TextStyle(fontSize: 22),)),
          ],),
        ),
        body: const TabBarView(children: [
          ListQuest(),
          ListQuest(),
          ListQuest(),
          ListQuest(),
          ListQuest(),
        ])
      ),
    );
  }
}
