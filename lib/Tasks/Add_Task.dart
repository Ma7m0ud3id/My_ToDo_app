import 'package:flutter/material.dart';

import '../Data_MOdel/Task_Model.dart';
import '../Data_fireBase/FireBase.dart';
import '../shared/components/components.dart';


class AddTaskBottomSheet extends StatefulWidget {


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'Add New Task',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline2

              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 4,
                      minLines: 4,
                      decoration: InputDecoration(labelText: 'Description',),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Select Time',style:Theme.of(context).textTheme.headline2?.copyWith(fontSize: 17) ,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  OpenDatePicker();
                },
                child: Text(
                  '${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}',
                  style:Theme.of(context).textTheme.headline2?.copyWith(fontSize: 17) ,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // local database /// mobile
                    // remote database  // online
                    TaskModel tas = TaskModel(
                        title: title,
                        description: description,
                        datetime: DateUtils.dateOnly(selectedDate)
                            .microsecondsSinceEpoch);
                    showLoading(context, 'Loading...');
                    addTaskFromFireBase(tas).then((value) {

                      hideLoadingDialog(context);
                      showMessage(context, 'Added Successfully ', 'Ok', () {
                        //print(true);
                        Navigator.pop(context);
                      });
                      Navigator.pop(context); // close bottom sheet
                    }).catchError((e) {
                      //print(false);
                      print(' error route $e');

                      hideLoadingDialog(context);
                    });
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void OpenDatePicker() async {
    var choosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (choosenDate != null) {
      selectedDate = choosenDate;
      setState(() {});
    }
  }
}
