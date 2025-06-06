import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/core/constants/app_colors.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:provider/provider.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    super.key,
    required this.context,
    required this.currentDate,
  });

  final BuildContext context;
  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostsProvider>(context);
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final lastDay = DateTime(currentDate.year, currentDate.month + 1, 0);
    final startingWeekday = firstDay.weekday;

    final daysInMonth = lastDay.day;
    final weeks = ((daysInMonth + startingWeekday - 1) / 7).ceil();

    return Column(
      children: List.generate(weeks, (week) {
        return Row(
          children: List.generate(7, (day) {
            final dayNumber = (week * 7) + day + 1 - startingWeekday;
            final isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
            final dayDate = isCurrentMonth
                ? DateTime(currentDate.year, currentDate.month, dayNumber)
                : null;

            final hasPosts =
                dayDate != null && provider.hasPostsForDate(dayDate);
            final isSelected = dayDate != null &&
                provider.isSameDate(dayDate, provider.selectedDate);

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (dayDate != null) {
                    provider.selectDate(dayDate);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : null,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isCurrentMonth ? '$dayNumber' : '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              hasPosts ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                      if (hasPosts)
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
