import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/CircleTapBar.dart';
import 'package:quest_planner/widgets/ListQuest.dart';
import 'package:quest_planner/widgets/app_large_text.dart';
import '../widgets/addQuest.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});
  @override
  State<QuestScreen> createState() => _QuestScreenState();
}
class _QuestScreenState extends State<QuestScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //menu text
              Container(
                padding: const EdgeInsets.only(top: 70, left: 20),
              ),
              const SizedBox(height: 40,),
              //discover text
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: AppLargeText(text: 'Quest Planner'),
              ),
              const SizedBox(height: 30,),
              //taoBar
              Container(
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabAlignment: TabAlignment.center,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CircleTabIndicator(color: Colors.indigo, radius: 5.0),
                  tabs: const [
                    Tab(child: Text('Tutti', style: TextStyle(fontSize: 15),),),
                    Tab(child: Text('Urgente', style: TextStyle(fontSize: 15),)),
                    Tab(child: Text('Prioritario', style: TextStyle(fontSize: 15),)),
                    Tab(child: Text('Secondario', style: TextStyle(fontSize: 15),)),
                    Tab(child: Text('Inbox', style: TextStyle(fontSize: 15),)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
          
              Container(
                height: 570,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: const[
                    ListQuest(),
                    ListQuest(),
                    ListQuest(),
                    ListQuest(),
                    ListQuest(),
                  ],
                )
              )
          
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showDialogAdd(context), child: Icon(Icons.add),),
    );

  }
  void _showDialogAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addQuest();
      },
    );
  }
}
