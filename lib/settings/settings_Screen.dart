import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model=SocialCubit.get(context).model;
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: model !=null,
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            height: 160,
                            width: double.infinity,
                            child: Image(
                              image:SocialCubit.get(context).model.cover==""? AssetImage("assets/images/person.png"):NetworkImage("${model.cover}"),

                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          radius: 58,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage:SocialCubit.get(context).model.image==""? AssetImage("assets/images/person.png"):NetworkImage("${model.image}"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text("${model.name}",style: Theme.of(context).textTheme.bodyText1,),
                  SizedBox(height: 10.0,),
                  Text("${model.bio}",style: Theme.of(context).textTheme.caption,),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                          child:InkWell(
                            child: Column(
                              children: [
                                Text("100",style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: 10.0,),

                                Text("Post",style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                      Expanded(
                          child:InkWell(
                            child: Column(
                              children: [
                                Text("265",style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: 10.0,),


                                Text("Photos",style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                      Expanded(
                          child:InkWell(
                            child: Column(
                              children: [
                                Text("10k",style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: 10.0,),

                                Text("Followers",style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )

                      ),
                      Expanded(
                          child:InkWell(
                            child: Column(
                              children: [
                                Text("65",style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: 10.0,),

                                Text("Following",style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: (){},
                            child: Text("Add Photos")),
                      ),
                      SizedBox(width: 15,),
                      OutlinedButton(
                        onPressed: (){
                          navigateTo(context, EditProfileScreen());
                        },
                        child:Icon(IconBroken.Edit),
                      )
                    ],
                  ),


                  SizedBox(height: 20,)

                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}
