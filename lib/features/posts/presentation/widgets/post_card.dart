import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liderate_flutter_challenge/core/constants/app_colors.dart';
import 'package:liderate_flutter_challenge/core/widgets/mock_image.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MockImage(
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(post.description),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy HH:mm')
                            .format(post.scheduledDate),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
