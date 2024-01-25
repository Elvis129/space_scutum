import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_space_scutum_2/note/constants/constants.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';

class AddFloatingActionButton extends StatelessWidget {
  const AddFloatingActionButton({super.key});

  void _showDialog(BuildContext context, NoteBloc noteBloc) {
    final noteKey = GlobalKey<FormState>();
    final categoryKey = GlobalKey<FormState>();

    TextEditingController noteController = TextEditingController();
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Додати нотатку'),
          backgroundColor: ConstantsColorWeather.colorBodyWeather,
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: categoryKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Категорія не може бути пустою';
                      }
                      return null;
                    },
                    controller: categoryController,
                    decoration:
                        const InputDecoration(hintText: 'Введіть категорію'),
                  ),
                ),
                Form(
                  key: noteKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Нотатка не може бути пустою';
                      }
                      return null;
                    },
                    maxLines: null,
                    controller: noteController,
                    decoration:
                        const InputDecoration(hintText: 'Введіть вашу нотатку'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Скасувати',
                  style: TextStyle(color: ConstantsColors.colorNote)),
            ),
            TextButton(
              onPressed: () {
                if ((categoryKey.currentState?.validate() ?? false) &&
                    (noteKey.currentState?.validate() ?? false)) {
                  noteBloc.add(AddNoteEvent(
                    noteController.text,
                    category: categoryController.text,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Додати',
                  style: TextStyle(color: ConstantsColors.colorNote)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    return FloatingActionButton(
      backgroundColor: ConstantsColorWeather.colorAppBarWeather,
      onPressed: () {
        _showDialog(context, noteBloc);
      },
      child: const Icon(Icons.add),
    );
  }
}
