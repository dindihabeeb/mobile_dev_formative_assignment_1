import 'package:flutter/foundation.dart';
import 'post.dart';

class PostStore {
  PostStore._();

  static final ValueNotifier<List<Post>> posts = ValueNotifier([
    Post(
      id: 'seed_1',
      type: 'Event',
      title: 'ALU Tech Showcase 2026',
      description: 'Student-built projects go live. Come see what the tech cohort has been building this semester.',
      date: DateTime.now().add(const Duration(days: 4)),
      location: 'ALU Innovation Hub',
      category: 'Tech',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Post(
      id: 'seed_2',
      type: 'Opportunity',
      title: 'Summer Internship — Andela',
      description: 'Andela is hiring ALU students for a 3-month remote engineering internship. Apply before slots fill up.',
      location: 'Remote',
      applyLink: 'andela.com/jobs',
      category: 'Careers',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Post(
      id: 'seed_3',
      type: 'Event',
      title: 'Kigali Campus 5K Run',
      description: 'Lace up and join the community run around campus. All fitness levels welcome.',
      date: DateTime.now().add(const Duration(days: 10)),
      location: 'Kigali Campus Grounds',
      category: 'Sports',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ]);

  static void add(Post post) {
    posts.value = [post, ...posts.value];
  }
}
