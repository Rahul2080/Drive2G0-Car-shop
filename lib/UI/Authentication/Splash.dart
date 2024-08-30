import 'package:drive2go/UI/Authentication/IntroPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomNavigation.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async{
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("userId")){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>Bottomnavigation()),(route)=>false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>Intropage()),(route) => false);
      }

    });


    return Scaffold(



    );
  }
}
