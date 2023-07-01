import 'dart:async';
import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:banao_flutter_task3/features/repository/notesRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NotesRepository notesRepository = NotesRepository();
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToAddNotesEvent>(homeNavigateToAddNotesEvent);
    on<HomeNavigateToViewNoteEvent>(homeNavigateToViewNoteEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final notesSnapshot =
        await notesRepository.notesCollection.orderBy("timeCreated").get();
    final notes = notesSnapshot.docs.map((doc) {
      return Notes(
        id: doc.id,
        title: doc['title'],
        description: doc['description'],
      );
    }).toList();
    emit(HomeLoadedSuccessState(notesModel: notes));
  }

  FutureOr<void> homeNavigateToAddNotesEvent(
      HomeNavigateToAddNotesEvent event, Emitter<HomeState> emit) {
    print("Add notes navigate button clicked");
    emit(HomeNavigateToAddNotesActionState());
  }

  FutureOr<void> homeNavigateToViewNoteEvent(
      HomeNavigateToViewNoteEvent event, Emitter<HomeState> emit) {
    print("Navigate to view note event clicked");
    emit(HomeNavigateToViewNotesActionState(noteId: event.noteId));
  }
}
