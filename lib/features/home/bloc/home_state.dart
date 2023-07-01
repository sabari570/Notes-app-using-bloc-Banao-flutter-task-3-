// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<Notes> notesModel;
  HomeLoadedSuccessState({
    required this.notesModel,
  });
}

class HomeErrorState extends HomeState {}

class HomeNavigateToAddNotesActionState extends HomeActionState {}

class HomeNavigateToViewNotesActionState extends HomeActionState {
  final String noteId;
  HomeNavigateToViewNotesActionState({
    required this.noteId,
  });
}
