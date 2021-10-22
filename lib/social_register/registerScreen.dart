import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layOut.dart';
import 'package:social_app/social_register/cubit/cubit.dart';
import '../constant.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState){
            navigateAndFinish(context,LayOutScreen());
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
                        Text("REGISTER",style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),
                        SizedBox(height: 15.0,),
                        Text("Register now to communicate with friends",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          controller:nameController ,
                          type: TextInputType.name,
                          validate: (String value){
                            if(value.isEmpty)
                              return "please enter your name";
                          },
                          label: "Name",
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 15,),
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
                            isPassword: SocialRegisterCubit.get(context).isPassword,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            suffixPressed: (){SocialRegisterCubit.get(context).changePasswordVisibility();},
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                          controller:phoneController ,
                          type: TextInputType.phone,
                          validate: (String value){
                            if(value.isEmpty)
                              return "please enter your phone";
                          },
                          label: "Phone",
                          prefix: Icons.phone,
                        ),
                        SizedBox(height: 15,),

                        ConditionalBuilder(
                          condition:state is! SocialRegisterLoadingState ,
                          builder:(context) => defaultButton(
                              function: (){
                                if (formKey.currentState.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password:passwordController.text,
                                    name:nameController.text,
                                    phone:phoneController.text,

                                  );
                                }
                              },
                              text: "Register"
                          ) ,

                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}


/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15