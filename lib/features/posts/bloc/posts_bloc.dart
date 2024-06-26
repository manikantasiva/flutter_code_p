import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:first_json_bloc/features/posts/models/postData_ui_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }
  

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    // here my loading state start >>>>
    emit(PostsFetchingLoadingState());
    var client = http.Client();
    List <PostDataUiModel> posts = [];
  try {
    var response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    List result = jsonDecode(response.body);

    print('INSIDE > TRY > postsInitialFetchEvent :: Response :');
    print(response.body);
    posts = postDataUiModelFromJson(response.body);

    print('PRINT MY POSTS ??:::');
    print(posts);
    
    emit(PostFetchingSuccessfullState(posts: posts)); // Emit success state with posts
  } catch (e) {
    emit(PostsFetchingErrorState());
    print('INSIDE > CATCH > postsInitialFetchEvent  E VALUE:::');
    print(e);
  }
    // try {
    //   // var response = await client.get(
    //   //   Uri.https('jsonplaceholder.typicode.com', '/posts'),
    //   // );
    //    var response = await client.get(
    //     Uri.parse('https://jsonplaceholder.typicode.com/posts', ),
    //   );
    //         List result = jsonDecode(response.body);

    //    print('INSIDE > TRY > postsInitialFetchEvent :: Response :');
    //   print(response.body);
    // } catch (e) {
    //   print('INSIDE > CATCH > postsInitialFetchEvent  E VALUE:::');
    //   print(e);
    // }
  }

}
