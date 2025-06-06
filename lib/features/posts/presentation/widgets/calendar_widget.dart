import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/widgets/calendar_grid.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostsProvider>(context);
    final currentDate = provider.currentMonth;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => provider.previousMonth(),
                ),
                Text(
                  '${_getMonthName(currentDate.month)} ${currentDate.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => provider.nextMonth(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Seg', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Ter', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Qua', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Qui', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Sex', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Sáb', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('Dom', style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            CalendarGrid(context: context, currentDate: currentDate),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    return months[month - 1];
  }
}
