import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/social_register/cubit/cubit.dart';
import 'package:social_app/styles/icon_broken.dart';

import 'login_secreen/social_login_screen.dart';
import 'network/cashHelper.dart';

final defaultColor=Colors.blue;

String uId="";


Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget>actions,
}){
  AppBar(
    leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(IconBroken.Arrow___Left_2)),
    title: Text("$title"),
    actions:actions ,


  );
}


Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase = true,
  @required Function function,
  @required String text,
  double radius=10.0,
})=> Container(width: width,decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),color: background),
    child:MaterialButton(onPressed: function,child: Text(isUpperCase?text.toUpperCase():text,style: TextStyle(color: Colors.white),),),
);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function suffixPressed,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  bool isPassword=false,
  bool enable=true,
})=> TextFormField(
controller: controller,
  obscureText: isPassword,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    enabled: enable,
    labelText:label,
    prefixIcon: Icon(prefix,),
    suffixIcon:suffix!=null? InkWell(onTap: suffixPressed,child: Icon(suffix)):null,
    border: OutlineInputBorder(),
  ),
);
Widget defaultText({@required Function onTap,@required String text,})=>InkWell(onTap:onTap,
child:Text(text.toUpperCase(),style: TextStyle(color: defaultColor,fontSize: 16,fontWeight: FontWeight.w700),) ,
);

void navigateTo(context,widget)=> Navigator.push(context,MaterialPageRoute(builder: (context) => widget,));
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder:(context) => widget,
    ),
        (route){
      return false;
    }
);
void printFullText(String text) {
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) =>print(element.group(0)));
}
void showToast({@required String txt,@required ToastStates state}){
Fluttertoast.showToast(
msg:txt,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0);
}
void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value) navigateAndFinish(context,LoginScreen());
  });
}
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

