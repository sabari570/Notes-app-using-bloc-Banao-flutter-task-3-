// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'view_note_bloc.dart';

@immutable
abstract class ViewNoteState {}

abstract class ViewNoteActionState extends ViewNoteState {}

class ViewNoteInitial extends ViewNoteState {}

class ViewNoteLoadingState extends ViewNoteState {}

class ViewNoteLoadedSuccessState extends ViewNoteState {
  final Notes notes;
  ViewNoteLoadedSuccessState({
    required this.notes,
  });
}

class ViewNoteErrorState extends ViewNoteState {}

class DeleteNoteAndNavigateToHomeActionState extends ViewNoteActionState {}
