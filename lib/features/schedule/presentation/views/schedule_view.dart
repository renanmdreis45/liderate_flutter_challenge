import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liderate_flutter_challenge/core/constants/app_colors.dart';
import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/core/widgets/custom_button.dart';
import 'package:liderate_flutter_challenge/core/widgets/custom_text_field.dart';
import 'package:liderate_flutter_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:liderate_flutter_challenge/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendar Postagem',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Título',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: _titleController,
                hintText: 'Digite o título da postagem',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Legenda',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: _descriptionController,
                hintText: 'Digite a legenda da postagem',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma legenda';
                  }
                  return null;
                },
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              const Text(
                'Agendamento',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration:
                        BoxDecoration(color: AppColors.textFieldBackground),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_month,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(
                          4.0,
                        ))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.access_time,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            onPressed: () => _selectTime(context),
                          ),
                          Text(_selectedTime.format(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  'Agendar',
                  onButtonPress: _schedulePost,
                  buttonColor: AppColors.primary,
                  textColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _schedulePost() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ScheduleProvider>(context, listen: false);

      final scheduledDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      try {
        await provider.schedulePost(
          title: _titleController.text,
          description: _descriptionController.text,
          scheduledDate: scheduledDateTime,
        );
        await Future.delayed(const Duration(milliseconds: 300));

        if (mounted) {
          Navigator.pop(context);
          Provider.of<PostsProvider>(context, listen: false).refreshPosts();
        }
      } on ValidationException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Ocorreu um erro ao agendar o post. Tente novamente.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
