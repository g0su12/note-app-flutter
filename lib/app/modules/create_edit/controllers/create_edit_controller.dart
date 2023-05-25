import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/app/data/notes_db.dart';
import 'package:note/app/models/note_model.dart';
import 'package:note/app/routes/app_pages.dart';

class CreateEditController extends GetxController {
  //TODO: Implement CreateEditController
  RxString dropdownValue = 'Không hẹn giờ'.obs;

  final count = 0.obs;

  Rx<DateTime> date = DateTime.now().obs;

  Rx<TimeOfDay> time = TimeOfDay.now().obs;

  NoteModel noteModel = Get.arguments;

  RxString category = ''.obs;

  RxBool isButtonEnabled = false.obs;

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  TextEditingController taskEditingController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();

  List<RxBool> checkBoxValue = <RxBool>[];


  final scrollController = ScrollController();

  RxList<dynamic> tasks = <dynamic>[].obs;

  List<String> items = ['Không hẹn giờ', 'Nhắc trước 5 phút'];

  @override
  void onInit() {
    super.onInit();
    category.value = noteModel.category;
    taskEditingController.addListener(onTextChanged);
    if(noteModel.tasks != null) {
      tasks.addAll(noteModel.tasks as Iterable);
      for (var element in tasks) {
        bool temp = element['isComplete'];
        checkBoxValue.add(temp.obs);
      }
    }
    titleEditingController.text = noteModel.title;
    contentEditingController.text = noteModel.content;
    locationEditingController.text = noteModel.location ?? '';
  }


  void onTextChanged() {
    isButtonEnabled.value = taskEditingController.text.isNotEmpty;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    taskEditingController.dispose();
    titleEditingController.dispose();
    contentEditingController.dispose();
    locationEditingController.dispose();
  }

  void getDatePicker(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
    );
    if(newDate != null) {
      date.value = newDate;
      noteModel.date = date.value;
    }
  }

  void getTimePicker(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(context: context,
        initialTime: time.value);
    if(newTime != null) {
      time.value = newTime;
    }
    noteModel.time = time.value.format(context);
  }

  void resetTime() {
    time.value = const TimeOfDay(hour: 0, minute: 0);
    noteModel.time = null;
  }

  void addChecklistItem(TextEditingController textEditingController) {
    var item = {
      'nameTask': textEditingController.text,
      'isComplete': false,
    };
    tasks.add(item);
    checkBoxValue.add(false.obs);
    noteModel.tasks!.add(item);
    textEditingController.clear();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  Future createNote() async {
    if(_formKey.currentState!.validate()) {
      NoteModel noteResult = NoteModel(
        id: noteModel.id,
        content: contentEditingController.text,
        category: category.value,
        date: date.value,
        title: titleEditingController.text == ''
            ? contentEditingController.text.substring(0,
            contentEditingController.text.length < 25 ?
            contentEditingController.text.length : 24)
            : titleEditingController.text,
        time: noteModel.time,
        tasks: tasks,
      );
      await DatabaseHelper.instance.saveOrUpdate(
          noteResult
      );
      Get.dialog(
          AlertDialog(
            title: const Text('Lưu thành công'),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.OVERVIEW);
                },
                child: const Text(
                  'OK',
                ),
              )
            ],
          )
      );
    }
  }

  void changeCategory(value) {
    category.value = value;
  }
}
