import 'package:drive2go/UI/Authentication/IntroPage.dart';
import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


    return Scaffold(backgroundColor: Colors.black,
body:Center(child: ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Container(child: Image.asset('assets/notificationViewimage.png',fit: BoxFit.cover,))))


    );
  }
}
