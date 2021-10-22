import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/new_post/new_post_screen.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class LayOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState)
          navigateTo(context, NewPostScreen());
      },
      builder: (context, state) {

        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex],),
            actions: [
              IconButton(onPressed: (){}, icon:Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon:Icon(IconBroken.Search)),
              OutlinedButton(
                onPressed: () {
                  signOut(context);
                },
                child: Text("signOut"),
              ),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon:Icon(IconBroken.Home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.travel_explore),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.bookmark_add_outlined),
                label: "Experience",
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.stars_outlined),
                label: "Rewards",
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.inbox_outlined),
                label: "Inbox",
              ),
            ],
          ),
        );
      },
    );
  }
}
