import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data_MOdel/Task_Model.dart';
import '../Data_fireBase/FireBase.dart';
import '../provid/my_provider.dart';
import '../shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Edit extends StatefulWidget {
static const String routName='Edit';
String id;
Edit(this.id);
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Container(
      margin: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
      color:  provider.ScaffoldColer(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    AppLocalizations.of(context)!.edittask,
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
                        style: TextStyle(color: provider.reversBottonColer()),

                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.titel,labelStyle:TextStyle(color: provider.reversBottonColer()) ),
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseentertasktitle;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        style: TextStyle(color: provider.reversBottonColer()),
                        maxLines: 4,
                        minLines: 4,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.description,labelStyle:TextStyle(color: provider.reversBottonColer())),
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseentertaskdescription;
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
                  AppLocalizations.of(context)!.selecttime,style:Theme.of(context).textTheme.headline2?.copyWith(fontSize: 17) ,
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
                      TaskModel tas1 = TaskModel(
                          title: title,
                          description: description,
                          id: widget.id,
                          datetime: DateUtils.dateOnly(selectedDate)
                              .microsecondsSinceEpoch);
                      showLoading(context, AppLocalizations.of(context)!.loading);
                      EditTaskFromFireStore(tas1).then((value) {

                        hideLoadingDialog(context);
                        showMessage(context, AppLocalizations.of(context)!.addedsuccessfully, AppLocalizations.of(context)!.ok, () {
                          //print(true);
                          Navigator.pop(context);
                        });
                        Navigator.pop(context); // close bottom sheet
                      }).catchError((e) {
                        //print(false);
                        print(AppLocalizations.of(context)!.errorroute +e);

                        hideLoadingDialog(context);
                      });
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.savechange),
                ),
              ],
            ),
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