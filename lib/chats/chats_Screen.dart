import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chat_details/chat_details_screen.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:SocialCubit.get(context).allUsers.length>0,
            builder: (context) => ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 0.5,thickness: 1,color: Colors.grey[500],),
              itemBuilder:(context, index) =>  buildChatItem(SocialCubit.get(context).allUsers[index],context) ,
              itemCount:SocialCubit.get(context).allUsers.length ,
                ),
            fallback: (context) => Center(child: Text("No Chats"),),
        );
      },
    );
  }
}
Widget buildChatItem(UserModel model,context) =>Padding(
  padding: const EdgeInsets.only(bottom:  10.0,right: 10,left: 10),
  child: InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model));
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage("${model.image}"),
          radius: 25,
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          "${model.name}",
          style:Theme.of(context).textTheme.subtitle1,
          overflow:TextOverflow.ellipsis ,
          maxLines: 1,
        ),
      ],
    ),
  ),
);
