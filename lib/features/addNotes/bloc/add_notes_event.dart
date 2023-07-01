// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_notes_bloc.dart';

@immutable
abstract class AddNotesEvent {}

class SaveNotesAndNavigateToHomeEvent extends AddNotesEvent {
  final Notes notesModel;
  SaveNotesAndNavigateToHomeEvent({
    required this.notesModel,
  });
}
