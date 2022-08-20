import 'package:flutter/material.dart';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';

import '../Data_MOdel/Task_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Data_fireBase/FireBase.dart';
import '../provid/my_provider.dart';
import '../shared/styles/my_theme.dart';
import 'Task_Itims.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskScreen extends StatefulWidget {


  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Container(
      color: provider.ScaffoldColer(),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) return;
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: provider.reversBottonColer(),//(dark mode change) (if)
            dayColor: provider.reversBottonColer(),//(dark mode change) (if)
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: provider.BottonColer(),//(dark mode change) (if)
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: provider.AppLanguage,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<TaskModel>>(
                stream: getTasksFromFirebaseUseingStream(selectedDate),
                builder: (contect, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!.somethingwentwrong);
                  }
                  List<TaskModel> tasks = snapshot.data?.docs
                      .map((docSnap) => docSnap.data())
                      .toList() ??
                      [];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskItem(tasks[index]);
                    },
                    itemCount: tasks.length,
                  );
                },
              )
          )
        ],
      ),
    );
  }
}
