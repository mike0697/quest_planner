
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/Cloud.dart';
import 'package:quest_planner/providers/quest_database.dart';
import 'package:quest_planner/providers/UserProvider.dart';
import 'package:quest_planner/screens/AuthPage.dart';
import 'package:quest_planner/screens/ProfileScreen.dart';
import 'package:quest_planner/screens/QuestScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quest_planner/widgets/addQuest.dart';
import 'Auth.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initialize note isar database
  await QuestDatabase.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => QuestDatabase()),
  ], child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quest Planner',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const MyHomePage(title: 'Quest Planner');
          } else{
            return AuthPage();
          }
        },

      ),


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    // Chiama la funzione per aggiornare i dati del provider all'avvio dell'app
    aggiornaPunteggio();
  }
  Future<void> aggiornaPunteggio() async {
    int punteggio = await Cloud().getUserPoint();
    int livello = await Cloud().getUserLevel();
    context.read<UserProvider>().setPunti(punteggio);
    context.read<UserProvider>().setLivello(livello);
    //"Valore ottenuto da Firebase: $punteggio"
  }

  @override
  Widget build(BuildContext context) {
    return const Widget028();
  }
}


//menu


class Widget028 extends StatefulWidget {
  const Widget028({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Widget028State();
}

class _Widget028State extends State<Widget028> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      QuestScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Quest',
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
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
