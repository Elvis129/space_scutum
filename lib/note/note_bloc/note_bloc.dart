import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_space_scutum_2/note/constants/constants.dart';

abstract class NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String note;
  final String category;

  AddNoteEvent(this.note, {required this.category});
}

class DeleteCategoryNoteEvent extends NoteEvent {
  final String note;
  final String category;

  DeleteCategoryNoteEvent(this.note, {required this.category});
}

class UpdateCategoriesEvent extends NoteEvent {}

abstract class NoteState {}

class InitialNoteState extends NoteState {
  final List<Note> notes;
  final List<String> categories;

  InitialNoteState(this.notes, this.categories);
}

class NoteAddedState extends NoteState {
  final List<Note> notes;
  final List<String> categories;

  NoteAddedState(this.notes, this.categories);
}

class Note {
  final String text;
  final String category;
  final Color color;
  final bool isCrossedOut;
  final TextDecoration? textNote;

  Note({
    required this.text,
    required this.category,
    this.color = ConstantsColors.colorNote,
    this.isCrossedOut = false,
    this.textNote,
  });

  // A method for serializing in JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'category': category,
      'color': color.value,
      'isCrossedOut': isCrossedOut,
    };
  }

  // A method to deserialize from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      text: json['text'],
      category: json['category'],
      color: Color(json['color']),
      isCrossedOut: json['isCrossedOut'],
    );
  }
}

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  late SharedPreferences _prefs;
  List<Note> notes = [];
  List<String> categories = [];

  Future<void> _saveDataToPrefs() async {
    final List<Map<String, dynamic>> serializedNotes =
        notes.map((note) => note.toJson()).toList();

    await _prefs.setString('notes', json.encode(serializedNotes));
    await _prefs.setStringList('categories', categories);
  }

  NoteBloc() : super(InitialNoteState([], [])) {
    _initPreferences();

    on<AddNoteEvent>((event, emit) {
      final newNote = Note(text: event.note, category: event.category);
      notes.add(newNote);

      if (!categories.contains(event.category)) {
        categories.add(event.category);
      }

      emit(NoteAddedState(List.from(notes), List.from(categories)));

      // Save data in shared preferences
      _saveDataToPrefs();
    });
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadDataFromPrefs();
  }

  void _loadDataFromPrefs() {
    final String serializedNotes = _prefs.getString('notes') ?? '[]';
    final List<Map<String, dynamic>> notesMapList =
        List<Map<String, dynamic>>.from(json.decode(serializedNotes));

    notes = notesMapList.map((noteMap) => Note.fromJson(noteMap)).toList();

    categories = _prefs.getStringList('categories') ?? [];
    emit(NoteAddedState(List.from(notes), List.from(categories)));
  }

  void deleteNote(Note note) {
    notes.remove(note);

    _saveDataToPrefs();
    emit(NoteAddedState(notes, _prefs.getStringList('categories') ?? []));
  }

  void deleteCategory(String category) {
    // We delete the notes of this category
    notes.removeWhere((note) => note.category == category);

    // We delete the category
    categories.remove(category);

    emit(NoteAddedState(List.from(notes), List.from(categories)));

    // Save data in shared preferences
    _saveDataToPrefs();
  }

  void changeNoteColor(Note note, bool isCrossedOut) {
    // Let's find the note index in the list
    final int index = notes.indexWhere((n) => n == note);

    if (index != -1) {
      // Let's update the colors and information about the strikethrough of the note text
      notes[index] = Note(
        text: note.text,
        category: note.category,
        color: isCrossedOut
            ? ConstantsColors.colorCheck
            : ConstantsColors.colorNote,
        isCrossedOut: isCrossedOut,
        textNote: isCrossedOut ? TextDecoration.lineThrough : null,
      );

      emit(NoteAddedState(List.from(notes), List.from(categories)));

      // Save data in shared preferences
      _saveDataToPrefs();
    }
  }

  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is AddNoteEvent) {
      final newNote = Note(text: event.note, category: event.category);
      notes.add(newNote);

      if (!categories.contains(event.category)) {
        categories.add(event.category);
      }

      yield NoteAddedState(List.from(notes), List.from(categories));

      await _saveDataToPrefs();
    } else if (event is UpdateCategoriesEvent) {
      yield NoteAddedState(List.from(notes), List.from(categories));
    }
  }

  List<Note> getNotesByCategory(String category) {
    return notes.where((note) => note.category == category).toList();
  }
}
