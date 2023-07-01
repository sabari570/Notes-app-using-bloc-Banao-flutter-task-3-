part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeNavigateToAddNotesEvent extends HomeEvent {}

class HomeNavigateToViewNoteEvent extends HomeEvent {
  final String noteId;
  HomeNavigateToViewNoteEvent({
    required this.noteId,
  });
}
