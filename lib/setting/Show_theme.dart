import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provid/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ShowBottonTheme extends StatefulWidget {


  @override
  State<ShowBottonTheme> createState() => _ShowBottonThemeState();
}

class _ShowBottonThemeState extends State<ShowBottonTheme> {
  @override
  Widget build(BuildContext context) {
    var pro2=Provider.of<MyProviderApp>(context);
    return Column(

      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: (){
            pro2.changeTheme(ThemeMode.light);
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(100, 8, 13, 31),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)
              ),
              child: Text(AppLocalizations.of(context)!.lightmode, style: Theme
                  .of(context)
                  .textTheme
                  .headline4,)),
        ),
        SizedBox(height: 15,),
        InkWell(
          onTap: (){
            pro2.changeTheme(ThemeMode.dark);
            Navigator.pop(context);
          },
          child: Container(

              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(100, 8, 13, 31),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)
              ),
              child: Text(AppLocalizations.of(context)!.darkmode, style: Theme
                  .of(context)
                  .textTheme
                  .headline4,)),
        ),
      ],
    );
  }
}

class ChangeLanguage{
  String sm;
  ChangeLanguage(this.sm) {

  }

}


