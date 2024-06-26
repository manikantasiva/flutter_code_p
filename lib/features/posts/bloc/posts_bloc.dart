import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:first_json_bloc/features/posts/models/postData_ui_model.dart';
import 'package:first_json_bloc/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);

    /// initial event here

    on<PostAddEvent>(postAddEvent);

    /// adding post event here
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    print('OOOOOOOO>>>>');
    print(posts);
    if (posts.isEmpty) {
      print('No posts found');
      emit(PostsFetchingErrorState());
    } else {
      print('Posts fetched successfully');
      emit(PostFetchingSuccessfullState(posts: posts));
    }
  }

  // FutureOr<void> postsInitialFetchEvent(
  //     PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
  //   // here my loading state start >>>>
  //   emit(PostsFetchingLoadingState());
  //   //   var client = http.Client();
  //   //   List <PostDataUiModel> posts = [];
  //   // try {
  //   //   var response = await client.get(
  //   //     Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  //   //   );
  //   //   List result = jsonDecode(response.body);

  //   //   print('INSIDE > TRY > postsInitialFetchEvent :: Response :');
  //   //   print(response.body);
  //   //   posts = postDataUiModelFromJson(response.body);
  //   List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
  //   print('PRINT MY POSTS ??:::');
  //   print(posts);
  //   emit(PostFetchingSuccessfullState(posts: posts));

  //   // }
  //   // catch (e) {
  //   //   emit(PostsFetchingErrorState());
  //   //   print('INSIDE > CATCH > postsInitialFetchEvent  E VALUE:::');
  //   //   print(e);
  //   // }

  // }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();

    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}
