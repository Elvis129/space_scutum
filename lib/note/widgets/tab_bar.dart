import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_space_scutum_2/note/constants/constants.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';
import 'package:test_task_space_scutum_2/weather/utilities/constants.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> categories;
  const MyTabBar({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
        return TabBar(
          indicatorColor: Colors.white,
          tabs: categories
              .map(
                (category) => GestureDetector(
                  child: Tab(text: category),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              ConstantsColorWeather.colorBodyWeather,
                          title: const Text(
                              'Ви впевнені що хочете видалити категорію?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Скасувати',
                                  style: TextStyle(
                                      color: ConstantsColors.colorNote)),
                            ),
                            TextButton(
                              onPressed: () {
                                noteBloc.deleteCategory(category);

                                Navigator.pop(context);
                              },
                              child: const Text('Видалити',
                                  style: TextStyle(
                                      color: ConstantsColors.colorNote)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
