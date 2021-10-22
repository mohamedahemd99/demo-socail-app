import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_app/login_secreen/cubit/states.dart';
import 'package:social_app/social_cubit/cubit.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit():super (SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword = ! isPassword;
    suffix =isPassword? Icons.visibility:Icons.visibility_off;
    emit(SocialLoginIsPasswordVisibilityState());
  }

  void userLogin({@required String email,@required String password,}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    )
    .then((value) {
      emit(SocialLoginSuccessState(value.user.uid));
    })
        .catchError((error)
    {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }


}