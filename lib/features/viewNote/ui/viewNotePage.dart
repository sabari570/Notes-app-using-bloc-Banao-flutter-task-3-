// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:banao_flutter_task3/features/home/ui/homePage.dart';
import 'package:banao_flutter_task3/features/viewNote/bloc/view_note_bloc.dart';
import 'package:banao_flutter_task3/features/widgets/appBarTitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewNotePage extends StatefulWidget {
  final String noteId;
  const ViewNotePage({Key? key, required this.noteId}) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  final ViewNoteBloc viewNoteBloc = ViewNoteBloc();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewNoteBloc.add(ViewNoteInitialEvent(noteId: widget.noteId));
  }

  @override
  Widget build(BuildContext context) {
    print("Buld called");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 237, 250),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        backgroundColor: const Color.fromARGB(255, 158, 183, 236),
        centerTitle: true,
        title: const AppBarTitleRow(
          title1: "View",
          title2: "Note",
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(
              Icons.add,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      body: BlocConsumer<ViewNoteBloc, ViewNoteState>(
        bloc: viewNoteBloc,
        listenWhen: (previous, current) => current is ViewNoteActionState,
        buildWhen: (previous, current) => current is! ViewNoteActionState,
        listener: (context, state) {
          if (state is DeleteNoteAndNavigateToHomeActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Note deleted successfully")));
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }), (route) => false);
          } else {
            return;
          }
        },
        builder: (context, state) {
          if (state is ViewNoteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ViewNoteLoadedSuccessState) {
            titleController.text = state.notes.title;
            descriptionController.text = state.notes.description;
            return Container(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    enabled: false,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title",
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            width: 2,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: descriptionController,
                    enabled: false,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            width: 2,
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ViewNoteErrorState) {
            return const Center(
              child: Text("Some error occured!!"),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          print("Delete note button clicked");
          viewNoteBloc.add(DeleteNoteAndNavigateToHomeEvent(
            notesDocId: widget.noteId,
          ));
        },
        label: Row(
          children: const [
            Icon(Icons.delete_rounded),
            SizedBox(
              width: 5,
            ),
            Text(
              "Delete note",
            ),
          ],
        ),
      ),
    );
  }
}
