import 'package:banao_flutter_task3/features/addNotes/bloc/add_notes_bloc.dart';
import 'package:banao_flutter_task3/features/home/models/notesModel.dart';
import 'package:banao_flutter_task3/features/home/ui/homePage.dart';
import 'package:banao_flutter_task3/features/widgets/appBarTitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final AddNotesBloc addNotesBloc = AddNotesBloc();
  final GlobalKey<FormState> notesFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          title1: "Add",
          title2: "Notes",
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
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Form(
          key: notesFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                onChanged: ((value) {}),
                validator: ((value) {
                  return value!.isEmpty ? "Please enter the title" : null;
                }),
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 3,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: null,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                validator: ((value) {
                  return value!.isEmpty ? "Please enter the description" : null;
                }),
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 3,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocListener<AddNotesBloc, AddNotesState>(
        bloc: addNotesBloc,
        listenWhen: (previous, current) => current is AddNotesActionState,
        listener: (context, state) {
          if (state is AddNotesAndNavigateToHomeActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Note added successfully")));
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }), (route) => false);
          }
        },
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 14, 163, 146),
          onPressed: () {
            if (notesFormKey.currentState!.validate()) {
              print("Go ahead and save the data");
              print("Title: " + titleController.text);
              print("Description: " + descriptionController.text);
              addNotesBloc.add(SaveNotesAndNavigateToHomeEvent(
                notesModel: Notes(
                    id: "",
                    title: titleController.text,
                    description: descriptionController.text),
              ));
            }
          },
          label: Row(
            children: const [
              Icon(Icons.save_as_rounded),
              SizedBox(
                width: 5,
              ),
              Text(
                "Save note",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
