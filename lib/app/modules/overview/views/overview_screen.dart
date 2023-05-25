import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/modules/overview/views/note_grid.dart';

import '../controllers/overview_controller.dart';

class OverViewScreen extends GetView<OverviewController> {
  const OverViewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,  //optional, starts from 0, select the tab by default
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: categories.map((category) => Tab(child: Text(category,
                  style: const TextStyle(fontSize: 16),
                ),)).toList(),
                onTap: controller.selectCategory,),
            ],
          ),
        ),
          body: Obx(
                () => TabBarView(
                children: categories
                    .map((category) => NoteGrid(
                  editButtonFunction: (noteModel) {
                    controller.toEditScreen(noteModel);
                  },
                  deleteButtonFunction: (noteModel) {
                    controller.deleteNote(noteModel);
                  },
                  category: category,
                  notes: controller.notes.where(
                          (note) => note.category == category).toList().obs,
                )).toList(),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toCreateScreen();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

final categories = ['Công việc', 'Cá nhân', 'Học Tập'];