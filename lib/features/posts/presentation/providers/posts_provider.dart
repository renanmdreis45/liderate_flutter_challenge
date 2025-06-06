import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_posts.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_posts_by_date.dart';

class PostsProvider with ChangeNotifier {
  final GetPosts getPosts;
  final GetPostsByDate getPostsByDate;

  PostsProvider({
    required this.getPosts,
    required this.getPostsByDate,
  });

  List<PostEntity> _posts = [];
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  List<PostEntity> get posts => _posts;
  DateTime get selectedDate => _selectedDate;
  DateTime get currentMonth => _currentMonth;

  Future<void> loadPosts() async {
    _posts = await getPosts.execute();
    notifyListeners();
  }

  Future<void> refreshPosts() async {
    await loadPosts();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void nextMonth() {
    _currentMonth = DateTime(
      _currentMonth.year + (_currentMonth.month == 12 ? 1 : 0),
      _currentMonth.month == 12 ? 1 : _currentMonth.month + 1,
      1,
    );
    notifyListeners();
  }

  void previousMonth() {
    _currentMonth = DateTime(
      _currentMonth.year - (_currentMonth.month == 1 ? 1 : 0),
      _currentMonth.month == 1 ? 12 : _currentMonth.month - 1,
      1,
    );
    notifyListeners();
  }

  bool hasPostsForDate(DateTime date) {
    return _posts.any((post) => isSameDate(post.scheduledDate, date));
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<PostEntity> getPostsForDate(DateTime date) {
    return _posts
        .where((post) => isSameDate(post.scheduledDate, date))
        .toList();
  }
}
