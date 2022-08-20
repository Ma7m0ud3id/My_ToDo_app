import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo_app/Tasks/Edit.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Data_MOdel/Task_Model.dart';
import '../Data_fireBase/FireBase.dart';
import '../provid/my_provider.dart';
import '../shared/components/components.dart';
import '../shared/styles/my_theme.dart';


class TaskItem extends StatefulWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProviderApp>(context);
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showLoading(context, AppLocalizations.of(context)!.loading);
              showMessage(
                  context,
                  AppLocalizations.of(context)!.areyousuretowantdeletethistask,
                  AppLocalizations.of(context)!.yes,
                      () {
                    deleteTask();
                    _navigator.pop();
                  },
                  NegActionName: AppLocalizations.of(context)!.cancel,
                  NegActionCallBack: () {
                    _navigator.pop();
                    hideLoadingDialog(context);
                  });
            },
            label: AppLocalizations.of(context)!.delete,
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .error,
            icon: Icons.delete,
          ),
        ],
      ),
      
        child: InkWell(
          onTap: (){
            BottomSheetEditTask(widget.taskModel.id);
          },
          child: Container(

            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: provider.BottonColer(),
                borderRadius: BorderRadius.circular(8)),
            //color of container tasks(dark mode change)
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 50,
                  color:  widget.taskModel.isDone==true?Colors.green:Color(0xFF5D9CEC),
                  width: 4,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.taskModel.title, style: TextStyle(fontSize: 25,
                          color: widget.taskModel.isDone==true?Colors.green:Color(0xFF5D9CEC),
                          //Color(0xFF5D9CEC),
                          fontWeight: FontWeight.w400,),

                        ),
                        Row(
                          children: [
                            // Icon(Icons.access_time,size: 15),
                            Text(
                                widget.taskModel.description, style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1?.copyWith(color:widget.taskModel.isDone==true?Colors.green:Color(0xFF5D9CEC) )

                            ),
                          ],
                        )

                      ],
                    )),
                ElevatedButton(
                  child: slectedDone(widget.taskModel.isDone),
                  onPressed: (){
                    if(widget.taskModel.isDone){
                      widget.taskModel.isDone=false;  //

                    }else{
                      widget.taskModel.isDone=true;
                    }
                    EditTaskFromFireStore(widget.taskModel);
                    // setState((){});
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(widget.taskModel.isDone==true?Colors.transparent:Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 40))),
                ),
                SizedBox(
                  width: 8,
                ),

              ],
            ),



      ),
        ),
    );
  }

  void deleteTask() {
    deleteTaskFromFireStore(widget.taskModel).then((value) {
      hideLoadingDialog(context);
    }).catchError((e) {
      hideLoadingDialog(context);
    });
  }

  BottomSheetEditTask( String id) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Edit(id);
        });
  }
  Widget slectedDone(bool done){
    if(done){
      return Text('Done!',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25 ),);
    }else{
      return Icon(Icons.done);
    }
  }
}
//Icon(Icons.check),