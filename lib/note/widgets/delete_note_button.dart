import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_space_scutum_2/note/constants/constants.dart';
import 'package:test_task_space_scutum_2/note/note_bloc/note_bloc.dart';

class DeleteNoteButton extends StatelessWidget {
  final Note note;

  const DeleteNoteButton({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);

    return IconButton(
      color: ConstantsColors.colorDeleteButton,
      icon: const Icon(Icons.delete),
      onPressed: () {
        noteBloc.deleteNote(note);
      },
    );
  }
}
