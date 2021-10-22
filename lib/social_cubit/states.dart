abstract class SocialStates{}

class SocialInitialState extends SocialStates{}
class SocialLoadingGetUserState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);

}
class SocialChangeNavBottomState extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialGetProfileImagePickedSuccessState extends SocialStates{}
class SocialGetProfileImagePickedErrorState extends SocialStates{}
class SocialGetCoverImagePickedSuccessState extends SocialStates{}
class SocialGetCoverImagePickedErrorState extends SocialStates{}
class SocialGetPostImagePickedSuccessState extends SocialStates{}
class SocialGetPostImagePickedErrorState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUpdateUserErrorState extends SocialStates{}
class SocialUpdateUserLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{}
class SocialGetPostLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{}
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{}
class SocialLikePostLoadingState extends SocialStates{}
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{}
class SocialCommentPostLoadingState extends SocialStates{}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}
class SocialClearPostImageState extends SocialStates{}
