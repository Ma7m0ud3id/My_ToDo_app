import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../provid/my_provider.dart';
class ShowBottom extends StatefulWidget {


  @override
  State<ShowBottom> createState() => _ShowBottomState();
}

class _ShowBottomState extends State<ShowBottom> {
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProviderApp>(context);
    return  Column(

      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: (){
            pro.changeLanguage('en');
            ChangeLanguage1('English');
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
              child: Text('English', style: Theme
                  .of(context)
                  .textTheme
                  .headline4,)),
        ),
        SizedBox(height: 15,),
        InkWell(
          onTap: (){
            pro.changeLanguage('ar');
            ChangeLanguage1('عربي');
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
              child: Text('عربي', style: Theme
                  .of(context)
                  .textTheme
                  .headline4,)),
        ),
      ],
    );
  }
}
class ChangeLanguage1{
   String Language;
  ChangeLanguage1(this.Language);

}


