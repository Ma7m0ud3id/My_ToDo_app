import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_todo_app/provid/my_provider.dart';
import 'package:my_todo_app/shared/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'layout/layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context){

        return MyProviderApp();
      },
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
late MyProviderApp provider;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((____)=>Sherdeprif() );
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     provider=Provider.of<MyProviderApp>(context);
     //Sherdeprif();
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      locale: Locale(provider.AppLanguage),
      debugShowCheckedModeBanner: false,
      routes: {
        MainScreen.routName:(c)=>MainScreen(),
      },
      initialRoute:MainScreen.routName ,
      themeMode: provider.themeMode,
      darkTheme: MyThemeData.DarkTheme,
      theme:MyThemeData.lightTheme ,
    );

  }

  void Sherdeprif()async{
    final prefs = await SharedPreferences.getInstance();
    String Language = prefs.getString('Language')??'en';
    provider.changeLanguage(Language);
    if(prefs.getString('Theme')=='dark'){
      provider.changeTheme(ThemeMode.dark);
    }
    else if (prefs.getString('Theme')=='light'){
      provider.changeTheme(ThemeMode.light);
    }

  }
}


