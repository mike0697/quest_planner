import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/ListQuest.dart';
import 'package:quest_planner/widgets/ListQuest/ListQuestInbox.dart';
import 'package:quest_planner/widgets/ListQuest/ListQuestPriority.dart';
import 'package:quest_planner/widgets/ListQuest/ListQuestSecondary.dart';
import 'package:quest_planner/widgets/ListQuest/ListQuestUrgenti.dart';
import 'addQuestPage.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});
  @override
  State<QuestScreen> createState() => _QuestScreenState();
}
class _QuestScreenState extends State<QuestScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: DefaultTabController(
      length: 5,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            const SliverAppBar(
              expandedHeight: 160,
              floating: true,
              pinned: true,
              stretch: false,
              centerTitle: false,
              title: Text('Quest Planner'),
              bottom: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.label,
                //indicator: CircleTabIndicator(color: Colors.indigo, radius: 5.0),
                tabs: [
                  Tab(child: Text('Tutti', style: TextStyle(fontSize: 15),),),
                  Tab(child: Text('Urgente', style: TextStyle(fontSize: 15),)),
                  Tab(child: Text('Prioritario', style: TextStyle(fontSize: 15),)),
                  Tab(child: Text('Secondario', style: TextStyle(fontSize: 15),)),
                  Tab(child: Text('Inbox', style: TextStyle(fontSize: 15),)),
                ],
              ),
            ),
          ];
        },
          body: const TabBarView(
            children: [
              ListQuest(priority: 'all',),
              ListQuestUrgent(),
              ListQuestPriority(),
              ListQuestSecondary(),
              ListQuestInbox(),
            ],
          ),
        ),
      ),
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute<void>(builder: (context) => AddQuestPage()));
    }, child: const Icon(Icons.add), ),
  );
}
