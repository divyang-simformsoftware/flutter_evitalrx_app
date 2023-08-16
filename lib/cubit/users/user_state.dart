import '../../model/user_model.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserFetchedState extends UserState {
  List<UserModel> userModelList = [];
  bool isLoadMore;
  bool isSearching;
  UserFetchedState(
      {required this.userModelList,
      required this.isLoadMore,
      required this.isSearching});
}

class UserExceptionState extends UserState {
  String errorMessage;
  UserExceptionState({required this.errorMessage});
}
