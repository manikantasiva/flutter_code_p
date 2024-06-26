import 'package:first_json_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constants/color_constants.dart';

class PostsListPage extends StatefulWidget {
  const PostsListPage({super.key});

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posts List',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: app_theam_clr1,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('PostAddEvent CLICKED >>>');
            postsBloc.add(PostAddEvent());
          }),
      body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            print(
                'State runtimeType: ${state.runtimeType}'); // Log the state type

            switch (state.runtimeType) {
              case PostsFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case PostFetchingSuccessfullState:
                final successState = state as PostFetchingSuccessfullState;
                print(
                    'Fetched Posts: ${successState.posts}'); // Log the entire list of posts
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10),
                  child: Container(
                    child: ListView.builder(
                        itemCount: successState.posts.length,
                        itemBuilder: (context, index) {
                          print(
                              'Current Index: $index'); // Log the current index
                          print(
                              'Current Post: ${successState.posts[index]}'); // Log the current post
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(successState.posts[index].title
                                        .toString()),
                                    Text(successState.posts[index].body
                                        .toString())
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );

              case PostsFetchingErrorState:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/nodata.jpg', // Replace with your asset image path
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No data found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );

              default:
                return SizedBox();
            }
          }),
    );
  }
}
