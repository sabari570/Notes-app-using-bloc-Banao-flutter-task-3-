// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'view_note_bloc.dart';

@immutable
abstract class ViewNoteEvent {}

class ViewNoteInitialEvent extends ViewNoteEvent {
  final String noteId;
  ViewNoteInitialEvent({
    required this.noteId,
  });
}

class DeleteNoteAndNavigateToHomeEvent extends ViewNoteEvent {
  final String notesDocId;
  DeleteNoteAndNavigateToHomeEvent({
    required this.notesDocId,
  });
}
