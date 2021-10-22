import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  var commentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model=SocialCubit.get(context);
        return ConditionalBuilder(
          condition: model.posts.length>0 && model.model!=null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        height: 200,
                        image: NetworkImage(
                            "https://image.freepik.com/free-photo/digital-device-mockup-with-daily-essentials-set_53876-141877.jpg"),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context, index) =>  buildPostItem(context,model.posts[index],index,commentController),
                    separatorBuilder:(context, index) => SizedBox(height: 10,) ,
                    itemCount: model.posts.length),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
Widget buildPostItem(context,PostModel model,index,TextEditingController commentController)=> Padding(
  padding: const EdgeInsets.all(8.0),
  child: Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${model.image}"),
                  radius: 25,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

                            Text(
                              "${model.name}",
                              style:Theme.of(context).textTheme.subtitle1,
                              overflow:TextOverflow.ellipsis ,
                              maxLines: 1,
                            ),
                            Icon(
                              Icons.verified,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          "${model.dateTime}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    )),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
            thickness: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
           "${model.text}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          // Container(
          //   padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(right: 6.0),
          //         height: 25,
          //         child: MaterialButton(
          //             onPressed: () {},
          //             minWidth: 1.0,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               "#football",
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .caption
          //                   .copyWith(color: defaultColor),
          //             )),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(right: 6.0),
          //         height: 25,
          //         child: MaterialButton(
          //             onPressed: () {},
          //             minWidth: 1.0,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               "#football",
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .caption
          //                   .copyWith(color: defaultColor),
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
          if(model.postImage!="")
            Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${model.postImage}"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${SocialCubit.get(context).likes[index]}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Message,
                        color: Colors.yellow[900],
                        size: 16,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${SocialCubit.get(context).comments[index]} comments",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              height: 1,
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "${SocialCubit.get(context).model.image}"),
                radius: 18,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        decoration:InputDecoration(
                          hintText: "write a comment...",
                          border: InputBorder.none
                        ) ,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index],commentController.text);
                        navigateTo(context,FeedsScreen());
                      },
                        icon:Icon(Icons.done))
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Send,
                      color: Colors.blue,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Share",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);