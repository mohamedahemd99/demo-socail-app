import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/chats/chats_Screen.dart';
import 'package:social_app/feeds/Feeds_Screen.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/new_post/new_post_screen.dart';
import 'package:social_app/settings/settings_Screen.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/users/users_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../constant.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel model;


  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chats",
    "Post",
    "Users",
    "Settings",
  ];
  void changeNavBottom(int index) {
    if(index==1){
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavBottomState());
    }
  }

  File profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialGetProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetCoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialGetCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage(
  {
  @required String name,
  @required String phone,
  @required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage( {
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());

      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void updateUserData(
      {
        @required String name,
        @required String phone,
        @required String bio,
        String image,
        String cover,
      }) {
    emit(SocialUpdateUserLoadingState());
    UserModel userModel = UserModel(
      email: model.email,
      name: name,
      phone: phone,
      uid: model.uid,
      bio: bio,
      image:image?? model.image,
      cover:cover?? model.cover,
      isEmailVerified: false,);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(userModel.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());});
  }
  void getUserData() {
    emit(SocialLoadingGetUserState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJason(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }


  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetPostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialGetPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
})
  {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            print(value);
            createPost(dateTime: dateTime, text: text,postImage: value);
          });
    } ).catchError((error){
      emit(SocialCreatePostErrorState());
    });

}

void createPost({
  @required String dateTime,
  @required String text,
  String postImage,
}){
    emit(SocialCreatePostLoadingState());
    PostModel postModel=PostModel(
      dateTime: dateTime,
      text: text,
      image:model.image,
      name: model.name,
      uid: model.uid,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
    .collection('posts')
    .add(postModel.toMap())
    .then((value) {
      emit(SocialCreatePostSuccessState());
    } ).catchError((error){
      emit(SocialCreatePostErrorState());
    });
}


void clearPostImage(){
    postImage =null;
    emit(SocialClearPostImageState());
}

List<PostModel> posts=[];
List<UserModel> allUsers=[];
List<String> postsId=[];
List<int> likes=[];
List<int> comments=[];

void getPosts(){
  FirebaseFirestore.instance
      .collection("posts")
      .get()
      .then((value) {
        value.docs.forEach((element) {
          element.reference.collection("likes").get().then((value){
            likes.add(value.docs.length);
            element.reference.collection("comments").get().then((value){
              comments.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJason(element.data()));
              emit(SocialGetPostSuccessState());
            });
          });
        });
        emit(SocialGetPostSuccessState());
  } )
      .catchError((error){
        emit(SocialGetPostErrorState());
  });
}
void getAllUsers(){
  if(allUsers.length==0)
  FirebaseFirestore.instance
      .collection("users")
      .get()
      .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uid']!=model.uid){
            allUsers.add(UserModel.fromJason(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
  } )
      .catchError((error){
        emit(SocialGetAllUsersErrorState());
  });
}

void likePost(String postId){
  FirebaseFirestore.instance
      .collection("posts")
      .doc(postId)
      .collection("likes")
      .doc(model.uid)
      .set({
    'like':true,
  }).then((value){
    emit(SocialLikePostSuccessState());
  })
      .catchError((error){
        emit(SocialLikePostErrorState());
  });
}

void commentPost(String postId,String comment){
  FirebaseFirestore.instance
      .collection("posts")
      .doc(postId)
      .collection("comments")
      .doc(model.uid)
      .set({
    'comment':comment,
  }).then((value){
    emit(SocialCommentPostSuccessState());
  })
      .catchError((error){
        emit(SocialCommentPostErrorState());
  });
}

void sendMessage({
  @required String receiverId,
  @required String text,
  @required String dateTime,
}){
  MessageModel messageModel = MessageModel(
    text: text,
    dateTime: dateTime,
    receiverId: receiverId,
    senderId: model.uid,
  );
  FirebaseFirestore.instance
  .collection('users')
  .doc(model.uid)
  .collection('chat')
  .doc(receiverId)
  .collection('messages')
  .add(messageModel.toMap())
  .then((value) {
    emit(SocialSendMessageSuccessState());
  })
  .catchError((error){
    emit(SocialSendMessageErrorState());
  });

  FirebaseFirestore.instance
      .collection('users')
      .doc(receiverId)
      .collection('chat')
      .doc(model.uid)
      .collection('messages')
      .add(messageModel.toMap())
      .then((value) {
    emit(SocialSendMessageSuccessState());
  })
      .catchError((error){
    emit(SocialSendMessageErrorState());
  });
}
List<MessageModel>messages=[];
void getMessages({@required String receiverId}){

  FirebaseFirestore.instance
      .collection('users')
      .doc(model.uid)
      .collection('chat')
      .doc(receiverId)
      .collection('messages')
      .orderBy('dateTime')
      .snapshots()
      .listen((event) {
        messages=[];
     event.docs.forEach((element) { 
       messages.add(MessageModel.fromJason(element.data()));
     });
     emit(SocialGetMessageSuccessState());
  });
}

}
