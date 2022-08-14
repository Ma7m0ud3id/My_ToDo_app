

import 'package:flutter/material.dart';


import '../shared/my_theme.dart';
import 'Show_Bottom.dart';
import 'Show_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Setting extends StatefulWidget {


  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.setting, style: Theme
              .of(context)
              .textTheme
              .headline2,textAlign: TextAlign.center),
          SizedBox(height: 15,),
          InkWell(
            onTap: () {
              ShowBottumLanguage();
            },

            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyThemeData.WhiteColor,
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)
                ),
                child: Text(AppLocalizations.of(context)!.language, style: Theme
                    .of(context)
                    .textTheme
                    .headline4?.copyWith(color: Color(0xFF5D9CEC)),)),
          ),
          SizedBox(height: 15,),
          InkWell(
            onTap: () {
              ShowBottumTheme1();
            },

            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyThemeData.WhiteColor,
                    border: Border.all(color: Theme
                        .of(context)
                        .primaryColor)
                ),
                child: Text(AppLocalizations.of(context)!.theme, style: Theme
                    .of(context)
                    .textTheme
                    .headline4?.copyWith(color: Color(0xFF5D9CEC)),)),
          ),
        ],
      ),
    );
  }
       void ShowBottumLanguage(){
          showModalBottomSheet(context: context, builder: (context){
          return ShowBottom();
      });
    }
  void ShowBottumTheme1(){
    showModalBottomSheet(context: context, builder: (context){
      return ShowBottonTheme();
    });
  }
  }

