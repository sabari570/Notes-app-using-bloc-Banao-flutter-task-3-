import 'dart:async';

import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:banao_flutter_task3/features/repository/notesRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_notes_event.dart';
part 'add_notes_state.dart';

class AddNotesBloc extends Bloc<AddNotesEvent, AddNotesState> {
  final NotesRepository notesRepository = NotesRepository();
  AddNotesBloc() : super(AddNotesInitial()) {
    on<SaveNotesAndNavigateToHomeEvent>(saveNotesAndNavigateToHomeEvent);
  }

  FutureOr<void> saveNotesAndNavigateToHomeEvent(
      SaveNotesAndNavigateToHomeEvent event,
      Emitter<AddNotesState> emit) async {
    final result = await notesRepository.addNotesToFirebase(event.notesModel);
    if (result != null) {
      emit(AddNotesAndNavigateToHomeActionState());
    }
  }
}
