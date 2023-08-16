import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/cubit/users/user_state.dart';
import '../../data/response_data.dart';
import '../../model/user_model.dart';

class UserCubit extends Cubit<UserState> {
  List<UserModel> _list = [];
  List<UserModel> _searchList = [];
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  int _indexPage = 0;
  int _endIndex = 20;
  final int _globalUserModelList = Response.getUserModelList().length;
  bool _isMorePage = false;

  UserCubit() : super(UserLoadingState()) {
    _getInitialData();
    scrollController.addListener(() {
      _scrollConfig();
    });
  }

  void _getInitialData() async {
    _list =
        Response.getUserModelList().getRange(_indexPage, _endIndex).toList();
    try {
      emit(UserFetchedState(
          userModelList: _list, isLoadMore: false, isSearching: false));
    } catch (e) {
      emit(UserExceptionState(errorMessage: e.toString()));
    }
  }

  void _scrollConfig() async {
    final currentScroll = scrollController.position.pixels;
    final maxScroll = scrollController.position.maxScrollExtent;
    if (currentScroll == maxScroll) {
      if (!_isMorePage) {
        _loadMore();
        _isMorePage = true;
      }
    }
  }

  void _loadMore() async {
    _indexPage = _list.length;
    _endIndex = 43;
    if (_list.length != _globalUserModelList) {
      emit(UserFetchedState(
          userModelList: _list, isLoadMore: true, isSearching: false));
      await Future.delayed(
        const Duration(seconds: 3),
        () {
          _list.addAll(Response.getUserModelList()
              .getRange(_indexPage, _endIndex)
              .toList());
          try {
            emit(UserFetchedState(
                userModelList: _list, isLoadMore: false, isSearching: false));
            _isMorePage = false;
          } catch (e) {
            emit(UserExceptionState(errorMessage: e.toString()));
            _isMorePage = false;
          }
        },
      );
    }
  }

  void updateRupeeOfIndex({required int index, required int changeRupee}) {
    if (_searchList.isNotEmpty) {
      _searchList.elementAt(index).rupee = changeRupee;
      emit(UserFetchedState(
          userModelList: _searchList, isLoadMore: false, isSearching: true));
    } else {
      _list.elementAt(index).rupee = changeRupee;

      emit(UserFetchedState(
          userModelList: _list, isLoadMore: false, isSearching: false));
    }
  }

  void searchData({required String searchQuery}) {
    if (searchQuery.isNotEmpty) {
      _searchList = _list.where(
        (element) {
          if (element.userName!.toLowerCase().contains(searchQuery) == true) {
            return true;
          } else if (element.phone!.toLowerCase().contains(searchQuery) ==
              true) {
            return true;
          } else if (element.city!.toLowerCase().contains(searchQuery) ==
              true) {
            return true;
          }
          return false;
        },
      ).toList();
      if (_searchList.isNotEmpty) {
        try {
          emit(UserFetchedState(
              userModelList: _searchList,
              isLoadMore: false,
              isSearching: true));
        } catch (e) {
          emit(UserExceptionState(errorMessage: e.toString()));
        }
      } else {
        _searchList.clear();
        emit(UserFetchedState(
            userModelList: [], isLoadMore: false, isSearching: true));
      }
    } else {
      _searchList.clear();
      emit(UserFetchedState(
          userModelList: _list, isLoadMore: false, isSearching: false));
    }
  }

  void clearText() {
    searchController.clear();
    emit(UserFetchedState(
        userModelList: _list, isLoadMore: false, isSearching: false));
  }
}
