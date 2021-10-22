import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  UserModel model;
  ChatDetailsScreen(this.model);
var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: model.uid);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener:(context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage("${model.image}"),
                      radius: 23,
                    ),
                    SizedBox(width: 15.0,),
                    Text("${model.name}",style:Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length>0,
                builder:(context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {

                              var message = SocialCubit.get(context).messages[index];

                              if(SocialCubit.get(context).model.uid==message.senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            },

                            separatorBuilder:(context, index) => SizedBox(height: 10,),
                            itemCount:SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        height: 50,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey[400],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller:messageController ,
                                  decoration: InputDecoration(
                                    hintText: "write message here ",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 50.0,
                              color:defaultColor,
                              child: InkWell(
                                  onTap: (){
                                    SocialCubit.get(context).sendMessage(
                                        receiverId:model.uid,
                                        text: messageController.text,
                                        dateTime:DateTime.now().toString()
                                    );
                                  },
                                  child: Icon(IconBroken.Send,size: 16,)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context) => Center(child: CircularProgressIndicator(),) ,
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(MessageModel model)=>Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration:BoxDecoration(
      color: Colors.grey[400],
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ) ,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
    child: Text('${model.text}'),
  ),
);
Widget buildMyMessage(MessageModel model)=>Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration:BoxDecoration(
      color: defaultColor.withOpacity(.2),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ) ,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
    child: Text('${model.text}'),
  ),
);