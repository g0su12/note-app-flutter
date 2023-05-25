import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/app/data/notes_db.dart';
import 'package:note/app/models/note_model.dart';
import 'package:note/app/modules/overview/views/overview_screen.dart';
import 'package:note/app/routes/app_pages.dart';

class OverviewController extends GetxController {
  //TODO: Implement OverviewController

  final count = 0.obs;

  var selectedCategory = 0.obs;

  RxList<NoteModel> notes = <NoteModel>[].obs;

  void getAllNotes() async {
    notes.addAll(await DatabaseHelper.instance.getAllNotes());
  }

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }


  void selectCategory(int categoryIndex) {
    selectedCategory.value = categoryIndex;
  }

  void toCreateScreen() {
    Get.toNamed(Routes.CREATE_EDIT,
        arguments: NoteModel(
            content: '',
            category: categories[selectedCategory.value],
            date: DateTime.now(),
            title: '',
          time: 'không',
          tasks: <dynamic>[],
        )
    );
  }

  void toEditScreen(NoteModel noteModel) {
    Get.toNamed(Routes.CREATE_EDIT,
      arguments: noteModel
    );
  }

  void increment() => count.value++;

  void deleteNote(NoteModel noteModel) {
    Get.dialog(AlertDialog(
      title: const Text('Bạn có chắc là muốn xóa ghi chú này không?'),
      actions: [
        GestureDetector(
          onTap: () {
            notes.remove(noteModel);
            DatabaseHelper.instance.delete(noteModel.id!);
            Get.back();
          },
          child: const Text('Có'),),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Text('Không'),),
      ],
    ));
  }
}
