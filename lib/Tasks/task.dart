import 'package:flutter/material.dart';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

import '../Data_MOdel/Task_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Data_fireBase/FireBase.dart';
import '../shared/my_theme.dart';
import 'Task_Itims.dart';

class TaskScreen extends StatefulWidget {


  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.OnprimaryColor,

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
            monthColor: MyThemeData.BlackColor,//(dark mode change) (if)
            dayColor: MyThemeData.BlackColor,//(dark mode change) (if)
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: MyThemeData.WhiteColor,//(dark mode change) (if)
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en',
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
                    return Text('Something went wrong');
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
