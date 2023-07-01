import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesRepository {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection("notes");

  Future addNotesToFirebase(Notes noteModel) async {
    try {
      return await notesCollection.add({
        'title': noteModel.title,
        'description': noteModel.description,
        'timeCreated': DateTime.now().toString()
      });
    } catch (e) {
      print("Exception is: " + e.toString());
      return null;
    }
  }

  Future<Notes?> getSingleNoteFromFirebase(String docId) async {
    try {
      return await notesCollection
          .doc(docId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return Notes(
              id: documentSnapshot.id,
              title: documentSnapshot['title'],
              description: documentSnapshot['description']);
        } else {
          print("No document with this id exists!!");
        }
        return null;
      });
    } catch (e) {
      print("Exception is: " + e.toString());
      return null;
    }
  }

  Future deleteNotesFromFirebase(String docId) async {
    try {
      return await notesCollection.doc(docId).delete();
    } catch (e) {
      print("Exception is: " + e.toString());
      return null;
    }
  }
}
