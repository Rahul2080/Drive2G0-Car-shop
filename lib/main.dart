import 'package:drive2go/Bloc/AllRentVehicles_Bloc/all_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/BuyAllVehicles_Bloc/buy_all_vehicles_bloc.dart';
import 'package:drive2go/Bloc/BuyNearVehicles_Bloc/buy_near_vehicles_bloc.dart';
import 'package:drive2go/Bloc/EditProfile_Bloc/edit_profile_bloc.dart';
import 'package:drive2go/Bloc/Feedback_Bloc/feedback_bloc.dart';
import 'package:drive2go/Bloc/GetAllRentVehiclesById_Bloc/get_all_rent_vehicles_by_id_bloc.dart';
import 'package:drive2go/Bloc/Login_Bloc/login_bloc.dart';
import 'package:drive2go/Bloc/MyOrderBuyVehicles_Bloc/my_order_buy_vehicles_bloc.dart';
import 'package:drive2go/Bloc/MyRentVehicles_Bloc/my_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/NearByRentVehicles_Bloc/near_by_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/NotificationByUserId_BLoc/notification_by_user_id_bloc.dart';
import 'package:drive2go/Bloc/OrderBuyVehicles_Bloc/order_buy_bloc.dart';
import 'package:drive2go/Bloc/OrderRentVehicles_Bloc/order_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:drive2go/Bloc/SearchBuyVehicles_Bloc/search_buy_vehicles_bloc.dart';
import 'package:drive2go/Bloc/SearchRentVehicles_Bloc/search_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/SendMessage_Bloc/send_message_bloc.dart';
import 'package:drive2go/Bloc/ShowSendMessage_Bloc/show_send_message_bloc.dart';
import 'package:drive2go/Bloc/Siginup_Bloc/signup_bloc.dart';
import 'package:drive2go/UI/Authentication/Splash.dart';
import 'package:drive2go/UI/Home_Pages/NotificationViewMarked.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Bloc/NotificationReadMessage_Bloc/notificatio_mark_read_bloc.dart';
import 'Repository/Api/Firebase_Message_Api.dart';
import 'firebase_options.dart';


TextEditingController pickuplocationcontroller = TextEditingController();
TextEditingController returnlocationcontroller = TextEditingController();
final Navigatorkey= GlobalKey< NavigatorState>();
late String fcm;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessageApi().Notifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
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
              BlocProvider(
                create: (context) => MyOrderBuyVehiclesBloc(),
              ),
              BlocProvider(
                create: (context) => FeedbackBloc(),
              ),
              BlocProvider(
                create: (context) => SendMessageBloc(),
              ),
              BlocProvider(
                create: (context) => EditProfileBloc(),
              ), BlocProvider(
                create: (context) => ShowSendMessageBloc(),
              ),
              BlocProvider(
                create: (context) => ProfileBloc(),
              ),
              BlocProvider(
                create: (context) => GetAllRentVehiclesByIdBloc(),
              ),
              BlocProvider(
                create: (context) => NotificationByUserIdBloc(),
              ),
              BlocProvider(
                create: (context) => NotificationMarkReadBloc(),
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
              navigatorKey: Navigatorkey,
              // routes:{ '/notification_screen': (context)=> NotificationPage()} ,
            ),
          );
        });
  }
}
