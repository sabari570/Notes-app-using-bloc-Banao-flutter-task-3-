import 'dart:async';

import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:banao_flutter_task3/features/repository/notesRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_note_event.dart';
part 'view_note_state.dart';

class ViewNoteBloc extends Bloc<ViewNoteEvent, ViewNoteState> {
  final NotesRepository notesRepository = NotesRepository();
  ViewNoteBloc() : super(ViewNoteInitial()) {
    on<ViewNoteInitialEvent>(viewNoteInitialEvent);
    on<DeleteNoteAndNavigateToHomeEvent>(deleteNoteAndNavigateToHomeEvent);
  }

  FutureOr<void> viewNoteInitialEvent(
      ViewNoteInitialEvent event, Emitter<ViewNoteState> emit) async {
    emit(ViewNoteLoadingState());
    final singleNote =
        await notesRepository.getSingleNoteFromFirebase(event.noteId);
    if (singleNote != null) {
      emit(ViewNoteLoadedSuccessState(notes: singleNote));
    }
  }

  FutureOr<void> deleteNoteAndNavigateToHomeEvent(
      DeleteNoteAndNavigateToHomeEvent event,
      Emitter<ViewNoteState> emit) async {
    await notesRepository.deleteNotesFromFirebase(event.notesDocId);
    emit(DeleteNoteAndNavigateToHomeActionState());
  }
}
