import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/core/routes/app_router.dart';
import 'package:liderate_flutter_challenge/core/routes/routes_names.dart';
import 'package:liderate_flutter_challenge/core/theme/app_theme.dart';
import 'package:liderate_flutter_challenge/data/repositories/post_repository_impl.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';
import 'package:liderate_flutter_challenge/domain/usecases/create_schedule.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_next_available_time.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_posts.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_posts_by_date.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/views/posts_view.dart';
import 'package:liderate_flutter_challenge/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PostRepository postRepository = PostRepositoryImpl();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostsProvider(
            getPosts: GetPosts(repository: postRepository),
            getPostsByDate: GetPostsByDate(repository: postRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleProvider(
            createSchedule: CreateSchedule(repository: postRepository),
            getNextAvailableTime:
                GetNextAvailableTime(repository: postRepository),
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const PostsView(),
        initialRoute: RouteNames.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    ),
  );
}
