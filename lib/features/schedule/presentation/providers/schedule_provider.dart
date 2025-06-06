import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/usecases/create_schedule.dart';
import 'package:liderate_flutter_challenge/domain/usecases/get_next_available_time.dart';

class ScheduleProvider with ChangeNotifier {
  final CreateSchedule _createSchedule;
  final GetNextAvailableTime _getNextAvailableTime;

  ScheduleProvider({
    required CreateSchedule createSchedule,
    required GetNextAvailableTime getNextAvailableTime,
  })  : _createSchedule = createSchedule,
        _getNextAvailableTime = getNextAvailableTime;

  bool _isLoading = false;
  String? _error;
  DateTime? _suggestedTime;

  bool get isLoading => _isLoading;
  String? get error => _error;
  DateTime? get suggestedTime => _suggestedTime;

  Future<bool> schedulePost({
    required String title,
    required String description,
    required DateTime scheduledDate,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final post = PostEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        scheduledDate: scheduledDate,
      );

      await _createSchedule.execute(post);
      return true;
    } on ValidationException catch (e) {
      _error = e.message;
      notifyListeners();
      rethrow;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSuggestedTime() async {
    _isLoading = true;
    notifyListeners();

    try {
      _suggestedTime = await _getNextAvailableTime.execute();
      _error = null;
    } catch (e) {
      _error = 'Failed to get available time';
      _suggestedTime = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
