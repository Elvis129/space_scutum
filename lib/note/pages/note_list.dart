import 'package:flutter/material.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';
import 'package:test_task_space_scutum_2/note/widgets/check_button.dart';
import 'package:test_task_space_scutum_2/note/widgets/delete_note_button.dart';

class NoteList extends StatelessWidget {
  final List<Note> categoryNotes;

  const NoteList({Key? key, required this.categoryNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Note> crossedOutNotes =
        categoryNotes.where((note) => !note.isCrossedOut).toList();
    final List<Note> nonCrossedOutNotes =
        categoryNotes.where((note) => note.isCrossedOut).toList();

    return ListView.builder(
      itemCount: categoryNotes.length,
      itemBuilder: (context, index) {
        final note = index < crossedOutNotes.length
            ? crossedOutNotes[index]
            : nonCrossedOutNotes[index - crossedOutNotes.length];
        return ListTile(
          title: Text(
            note.text,
            style: TextStyle(color: note.color, decoration: note.textNote),
          ),
          leading: CheckButton(note: note),
          trailing: DeleteNoteButton(note: note),
        );
      },
    );
  }
}
