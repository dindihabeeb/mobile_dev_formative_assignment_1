import 'package:flutter/foundation.dart';
import 'post.dart';

class PostStore {
  PostStore._();

  static final ValueNotifier<List<Post>> posts = ValueNotifier([]);

  static void add(Post post) {
    posts.value = [post, ...posts.value];
  }
}
