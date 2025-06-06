import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/core/widgets/custom_app_bar.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/widgets/calendar_widget.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/widgets/post_card.dart';
import 'package:liderate_flutter_challenge/features/schedule/presentation/views/schedule_view.dart';
import 'package:provider/provider.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await Provider.of<PostsProvider>(context, listen: false).loadPosts();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<PostsProvider>(
              builder: (context, provider, _) {
                final posts = provider.getPostsForDate(provider.selectedDate)
                  ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

                return ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    Center(
                      child: Text(
                        'Postagens agendadas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CalendarWidget(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Postagens agendadas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (posts.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child:
                              Text('Nenhuma postagem agendada para esta data'),
                        ),
                      )
                    else
                      ...posts.map((post) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: PostCard(post: post),
                              ),
                              const SizedBox(height: 8),
                            ],
                          )),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScheduleView()),
          );
          await _loadPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
