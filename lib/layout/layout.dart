import 'package:flutter/material.dart';
import '../Tasks/Add_Task.dart';
import '../Tasks/task.dart';
import '../provid/my_provider.dart';
import '../setting/Setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class MainScreen extends StatefulWidget {
  static const String routName='kljok';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

int count=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todolist,style: Theme.of(context).textTheme.headline1,),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
         color: provider.BottonColer(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
            elevation: 0,
          onTap:(index){
            count=index;
            setState((){});
          },
            currentIndex:count,
          items:[
          BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: '')
          ]
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            BottomSheetAddTask();
          },
      shape: StadiumBorder(
      side: BorderSide(
      color: provider.BottonColer() ,//change Dark mode (if)
      width: 4,
      ))),
      body:tap[count] ,
      );
  }

  List<Widget> tap=[TaskScreen(),Setting()];
    BottomSheetAddTask(){
   showModalBottomSheet(
       context: context,
       builder: (context) {
         return AddTaskBottomSheet();
       });



}
}
