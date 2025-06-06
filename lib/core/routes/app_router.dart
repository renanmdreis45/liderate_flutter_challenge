import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/views/posts_view.dart';
import 'package:liderate_flutter_challenge/features/schedule/presentation/views/schedule_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PostsView());
      case '/schedule':
        return MaterialPageRoute(builder: (_) => const ScheduleView());
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text('Route "$routeName" not found'),
        ),
      ),
    );
  }
}
