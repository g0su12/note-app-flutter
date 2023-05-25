import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note/app/models/note_model.dart';

class NoteGrid extends StatelessWidget {
  final String category;
  final RxList<NoteModel> notes;
  final Function(NoteModel noteModel) editButtonFunction;
  final Function(NoteModel noteModel) deleteButtonFunction;


  const NoteGrid({Key? key,
    required this.category,
    required this.notes,
    required this.editButtonFunction,
    required this.deleteButtonFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List categoryNotes = notes.where(
            (note) => note.category == category).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 250,
        ),
        itemCount: categoryNotes.length,
        itemBuilder: (context, index) {
          final note = categoryNotes[index];
          return InkWell(
            onTap: () {
              editButtonFunction(note);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      note.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(note.date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      note.time != null ? note.time!.toString() : "Không",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            deleteButtonFunction(note);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            editButtonFunction(note);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}