import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo_app/Tasks/Edit.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Data_MOdel/Task_Model.dart';
import '../Data_fireBase/FireBase.dart';
import '../provid/my_provider.dart';
import '../shared/components/components.dart';
import '../shared/my_theme.dart';


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
                color: Color(0xFF5D9CEC),
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
                        color: Color(0xFF5D9CEC),
                        fontWeight: FontWeight.w400,),

                      ),
                      Row(
                        children: [
                          // Icon(Icons.access_time,size: 15),
                          Text(
                              widget.taskModel.description, style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1

                          ),
                        ],
                      )

                    ],
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xFF5D9CEC),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 25,
                ),
              )
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
        context: context,
        builder: (context) {
          return Edit(id);
        });
  }
}