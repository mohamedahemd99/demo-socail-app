import 'package:conditional_builder/conditional_builder.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layOut.dart';
import 'package:social_app/login_secreen/cubit/cubit.dart';
import 'package:social_app/login_secreen/cubit/states.dart';
import 'package:social_app/network/cashHelper.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_register/registerScreen.dart';
import '../constant.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state) {

          if(state is SocialLoginErrorState){
            showToast(txt: state.error, state:ToastStates.ERROR);
          }

          if(state is SocialLoginSuccessState)
          {
           CacheHelper.saveData(
                key:'uId',
                value:state.uid
            ).then((value)
            {
              navigateAndFinish(
                context,
                LayOutScreen()
            );});
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),
                        SizedBox(height: 15.0,),
                        Text("Login now to communicate with friends",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),),
                        SizedBox(height: 30.0,),
                        defaultFormField(

                          controller:emailController ,
                          type: TextInputType.emailAddress,
                          validate: (String value){
                            if(value.isEmpty)
                              return "please enter your email address";
                          },
                          label: "Email",
                          prefix: Icons.email,
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller:passwordController ,
                            type: TextInputType.visiblePassword,
                            validate: (String value){
                              if(value.isEmpty)
                                return "password is too short";
                            },

                            label: "Password",
                            prefix: Icons.lock_outline,
                            isPassword: SocialLoginCubit.get(context).isPassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: (){SocialLoginCubit.get(context).changePasswordVisibility();},
                            onSubmit: (value){
                              if (formKey.currentState.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password:passwordController.text
                                );
                              }}
                        ),
                        SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition:state is! SocialLoginLoadingState ,
                          builder:(context) => defaultButton(
                              function: (){
                                if (formKey.currentState.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password:passwordController.text,
                                  );
                                }
                              },
                              text: "Login"
                          ) ,

                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account?   ",),
                            defaultText(onTap: (){
                              navigateTo(context,RegisterScreen() );
                            }, text:"register")

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
