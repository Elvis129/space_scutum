import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';
import 'package:test_task_space_scutum_2/note/pages/note_list.dart';
import 'package:test_task_space_scutum_2/note/widgets/add_floating_action_button.dart';
import 'package:test_task_space_scutum_2/note/widgets/tab_bar.dart';
import 'package:test_task_space_scutum_2/note/widgets/weather_button.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';

class MyNoteApp extends StatelessWidget {
  const MyNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
      if (state is InitialNoteState) {
        return Scaffold(
            floatingActionButton: const AddFloatingActionButton(),
            appBar: AppBar(
              title: const Text('Блокнот'),
              centerTitle: true,
              backgroundColor: ConstantsColorWeather.colorAppBarWeather,
              actions: const [WeatherButton()],
            ),
            backgroundColor: ConstantsColorWeather.colorBodyWeather,
            body: const Center(
              child: Text('Додайте ваші нотатки.'),
            ));
      } else if (state is NoteAddedState) {
        return DefaultTabController(
          length: noteBloc.categories.length,
          child: Scaffold(
            floatingActionButton: const AddFloatingActionButton(),
            appBar: AppBar(
              title: const Text('Блокнот'),
              centerTitle: true,
              backgroundColor: ConstantsColorWeather.colorAppBarWeather,
              actions: const [WeatherButton()],
              bottom: MyTabBar(
                categories: noteBloc.categories,
              ),
            ),
            backgroundColor: ConstantsColorWeather.colorBodyWeather,
            body: TabBarView(
              children: noteBloc.categories.map((category) {
                final categoryNotes = noteBloc.getNotesByCategory(category);
                return NoteList(categoryNotes: categoryNotes);
              }).toList(),
            ),
          ),
        );
      }
      return Container();
    });
  }
}
