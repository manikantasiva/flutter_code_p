import 'dart:convert';
import 'package:first_json_bloc/features/posts/models/postData_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      List result = jsonDecode(response.body);

      print('INSIDE > TRY > postsInitialFetchEvent :: Response :');
      print(response.body);
      posts = postDataUiModelFromJson(response.body);
      return posts;
    } catch (e) {
      print('INSIDE > CATCH ******> postsInitialFetchEvent  E VALUE:::');
      print(e);
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Manikanta siva",
        "body": "Manikanta Mobile Developer , .....",
        "userId": "20000000000"
      });
  print('FORRRR > statusCode  E VALUE:::');
  print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300) {
         print('1111:::');
        return true;
      } else {
        print('2222:::');
        return false;
      }
    } catch (e) {
      print('INSIDE > CATCH > addPost  E VALUE:::');
      print(e);
      return false;
    }
  }
}
