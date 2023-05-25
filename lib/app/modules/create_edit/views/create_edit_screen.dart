import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note/app/modules/create_edit/views/widget/app_dropdown_formfield.dart';
import 'package:note/app/modules/overview/views/overview_screen.dart';

import '../controllers/create_edit_controller.dart';

class CreateEditScreen extends GetView<CreateEditController> {
  const CreateEditScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(DateFormat('dd/MM/yyyy').format(controller.date.value)),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {

              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                controller.createNote();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: AppDropdownFormField(
                                list: categories,
                                onChange: (value) {
                                  controller.changeCategory(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getDatePicker(context);
                                },
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Text(DateFormat('dd/MM/yyyy')
                                          .format(controller.date.value)),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        //Danh mục + Date
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: controller.titleEditingController,
                          maxLength: 64,
                          decoration: const InputDecoration(
                            hintText: "Tiêu đề",
                          ),
                        ),
                        //Tiêu đề
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: controller.contentEditingController,
                          maxLines: 20,
                          maxLength: 1024,
                          decoration: const InputDecoration(
                            hintText: "Nội dung ghi chú",
                            fillColor: Colors.yellow,
                            filled: true,
                          ),
                        ),
                        //Note content
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: controller.locationEditingController,
                          maxLength: 128,
                          decoration: const InputDecoration(
                            hintText: "Địa điểm",
                          ),
                        ),
                        //Location
                        const SizedBox(height: 16.0),
                        Obx(
                            () => Row(
                            children: [
                              Flexible(
                                  child: DropdownButton(
                                      items: controller.items.map<DropdownMenuItem<String>>(
                                              (String dropdownValue) {
                                        return DropdownMenuItem<String>(
                                          value: dropdownValue,
                                          child: Text(dropdownValue),
                                        );
                                      }).toList(),
                                      value: controller.dropdownValue.value,
                                      onChanged: (value) {
                                        controller.dropdownValue.value = value!;
                                        if(controller.dropdownValue.value == controller.items[0]) {
                                          controller.resetTime();
                                        }
                                      }),
                                ),
                              const SizedBox(
                                width: 12,
                              ),
                              if(controller.dropdownValue.value == controller.items[1])
                                Flexible(child: GestureDetector(
                                  onTap: () {
                                    controller.getTimePicker(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(controller.time.value.format(context)),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Obx(
                          () => ListView.separated(
                            controller: controller.scrollController,
                            itemCount: controller.tasks.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_,int index) =>
                                Row(
                                  children: [
                                    Text(
                                      controller.tasks[index]['nameTask'],
                                      style: const TextStyle(
                                        fontSize: 16
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Obx(
                                        () => Checkbox(
                                          value: controller.checkBoxValue
                                          [index].value,
                                          onChanged: (bool? value) {
                                            controller.checkBoxValue
                                            [index].value = value!;
                                      }),
                                    )
                                  ],
                                ),
                            separatorBuilder: (_,__) {
                              return const SizedBox(height: 10,);
                            },
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Obx(
                          () => Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controller.taskEditingController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nhiệm vụ',
                                    ),
                                  ),
                                ),
                                  IconButton(
                                    icon: Icon(Icons.add,
                                      color: controller.isButtonEnabled.value
                                          ? Colors.black : Colors.grey,
                                    ),
                                    onPressed: controller.isButtonEnabled.value ?
                                        () { controller.addChecklistItem(
                                          controller.taskEditingController);
                                    } : null,
                                  ),
                              ],
                            ),
                        ),
                      ]
                ),
              )),
        ));
  }
}
