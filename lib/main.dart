import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/layOut.dart';
import 'package:social_app/login_secreen/social_login_screen.dart';
import 'package:social_app/network/cashHelper.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/themes.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());

  showToast(txt: "BackGround", state: ToastStates.SUCCESS);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  
  var token=await  FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    showToast(txt: "onMessage", state: ToastStates.SUCCESS);

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

    showToast(txt: "on Message Opened App", state: ToastStates.SUCCESS);
  });
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  Widget widget;

  uId= CacheHelper.get(key:'uId');


  if(uId!=null){
    widget=LayOutScreen();
  }
  else{
    widget=LoginScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
          BlocProvider(
              create:(context) => SocialCubit()..getUserData()..getPosts(),
          )
        ],
        child:BlocConsumer<SocialCubit,SocialStates>(
          listener:(context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:lightTheme ,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home:startWidget,
            );
          },
        )
    );
  }
}
