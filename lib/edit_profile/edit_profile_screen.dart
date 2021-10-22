import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=model.name;
        bioController.text=model.bio;
        phoneController.text=model.phone;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            title: Text("Edit Profile"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text
                  );
                },
                child: Text("UPDATE"),
              ),
              SizedBox(
                width: 5.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                height: 160,
                                width: double.infinity,
                                child: Image(
                                  image:coverImage==null? NetworkImage("${model.cover}"):FileImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                    radius: 20,
                                  )),
                            ],
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 58,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:profileImage ==null? NetworkImage("${model.image}"):FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                  radius: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage !=null||SocialCubit.get(context).coverImage !=null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(function: (){
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              }, text:"Upload Image"),
                              if(state is SocialUpdateUserLoadingState)
                                SizedBox(height: 5.0),
                              if(state is SocialUpdateUserLoadingState)
                               LinearProgressIndicator(),
                            ],
                          )),
                      SizedBox(width: 5.0,),
                      if(SocialCubit.get(context).coverImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(function: (){
                                SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                              }, text:"Cover Image"),
                              if(state is SocialUpdateUserLoadingState)
                                SizedBox(height: 5.0),
                              if(state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  defaultFormField(
                      controller: nameController,
                      type:TextInputType.name ,
                      validate: (String value){
                        if(value.isEmpty){
                          return "please enter your name";
                        }
                        else
                          return null;
                      },
                      label: "name",
                      prefix:IconBroken.User
                  ),
                  SizedBox(height: 15,),
                  defaultFormField(
                      controller: bioController,
                      type:TextInputType.emailAddress,
                      validate: (String value){
                        if(value.isEmpty){
                          return "please enter bio here ";
                        }
                        else
                          return null;
                      },
                      label: "bio",
                      prefix:IconBroken.Info_Circle
                  ),
                  SizedBox(height: 15,),

                  defaultFormField(
                      controller: phoneController,
                      type:TextInputType.phone,
                      validate: (String value){
                        if(value.isEmpty){
                          return "please enter your number here ";
                        }
                        else
                          return null;
                      },
                      label: "phone",
                      prefix:IconBroken.Call
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
