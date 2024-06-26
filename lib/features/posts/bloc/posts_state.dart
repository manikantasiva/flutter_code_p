part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchingLoadingState extends PostsState {}

class PostsFetchingErrorState extends PostsState {}


class PostFetchingSuccessfullState extends PostsState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfullState({required this.posts});
}


