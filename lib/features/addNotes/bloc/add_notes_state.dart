part of 'add_notes_bloc.dart';

@immutable
abstract class AddNotesState {}

abstract class AddNotesActionState extends AddNotesState {}

class AddNotesInitial extends AddNotesState {}

class AddNotesAndNavigateToHomeActionState extends AddNotesActionState {}
