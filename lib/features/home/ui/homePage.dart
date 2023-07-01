import 'package:banao_flutter_task3/features/home/bloc/home_bloc.dart';
import 'package:banao_flutter_task3/features/addNotes/ui/addNotesPage.dart';
import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:banao_flutter_task3/features/viewNote/ui/viewNotePage.dart';
import 'package:banao_flutter_task3/features/widgets/appBarTitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 237, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 183, 236),
        centerTitle: true,
        title: const AppBarTitleRow(
          title1: "Notes",
          title2: "App",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 14, 163, 146),
        onPressed: () {
          homeBloc.add(HomeNavigateToAddNotesEvent());
        },
        child: const Icon(Icons.note_add),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToAddNotesActionState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddNotesPage();
            }));
          } else if (state is HomeNavigateToViewNotesActionState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewNotePage(
                noteId: state.noteId,
              );
            }));
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoadedSuccessState) {
            final notes = state.notesModel;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: notes.isEmpty
                  ? const Center(
                      child: Text("No Notes Created"),
                    )
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            homeBloc.add(HomeNavigateToViewNoteEvent(
                                noteId: notes[index].id));
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black38, width: 2),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 5, // Blur radius
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notes[index].title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  notes[index].description,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            );
          } else if (state is HomeErrorState) {
            return const Center(
              child: Text("Some error occured!!"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
