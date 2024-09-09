import 'package:drive2go/Bloc/AllRentVehicles_Bloc/all_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/BuyAllVehicles_Bloc/buy_all_vehicles_bloc.dart';
import 'package:drive2go/Bloc/BuyNearVehicles_Bloc/buy_near_vehicles_bloc.dart';
import 'package:drive2go/Bloc/Login_Bloc/login_bloc.dart';
import 'package:drive2go/Bloc/MyRentVehicles_Bloc/my_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/NearByRentVehicles_Bloc/near_by_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/OrderBuyVehicles_Bloc/order_buy_bloc.dart';
import 'package:drive2go/Bloc/OrderRentVehicles_Bloc/order_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/SearchBuyVehicles_Bloc/search_buy_vehicles_bloc.dart';
import 'package:drive2go/Bloc/SearchRentVehicles_Bloc/search_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/Siginup_Bloc/signup_bloc.dart';
import 'package:drive2go/UI/Authentication/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'UI/Authentication/IntroPage.dart';

TextEditingController pickuplocationcontroller = TextEditingController();
TextEditingController returnlocationcontroller = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignupBloc(),
              ),
              BlocProvider(
                create: (context) => LoginBloc(),
              ),
              BlocProvider(
                create: (context) => NearByRentVehiclesBloc(),
              ),
              BlocProvider(
                create: (context) => AllRentVehiclesBloc(),
              ),
              BlocProvider(
                create: (context) => OrderRentVehiclesBloc(),
              ),
              BlocProvider(
                create: (context) => MyRentVehiclesBloc(),
              ),
              BlocProvider(create: (context) => SearchRentVehiclesBloc()),
              BlocProvider(create: (context) => BuyNearVehiclesBloc()),
              BlocProvider(create: (context) => BuyAllVehiclesBloc()),
              BlocProvider(
                create: (context) => SearchBuyVehiclesBloc(),
              ),
              BlocProvider(
                create: (context) => OrderBuyBloc(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Splash(),
            ),
          );
        });
  }
}
