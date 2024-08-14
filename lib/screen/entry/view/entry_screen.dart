import 'package:budgt_trocker/screen/category/controller/category_controller.dart';
import 'package:budgt_trocker/screen/entry/controller/entry_controller.dart';
import 'package:budgt_trocker/screen/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  EntryController controller = Get.put(EntryController());
  CategoryController categoryController = Get.put(CategoryController());
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD to Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtTitle,
              decoration: const InputDecoration(
                label: Text("title"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: txtAmount,

              decoration: const InputDecoration(
                label: Text("amount"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => DropdownButtonFormField(
                value: "${categoryController.categoryList}",
                items: List.generate(
                  categoryController.categoryList.length,
                  (index) {
                   categoryController.categoryList[index].name!;
                  },
                ),
                onChanged: (value) {
                  categoryController.getCategory();
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now(),
                    );
                  },
                  label: Obx(
                    () => Text(
                        "${controller.date.value.day}-${controller.date.value.month}-${controller.date.value.year}"),
                  ),
                  icon: const Icon(Icons.calendar_month),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  label: Obx(() => Text(
                      "${controller.time.value.hour}:${controller.time.value.minute}")),
                  icon: const Icon(Icons.access_time_filled),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      DBHelper helper = DBHelper();
                      helper.insertIncameExpens(
                          txtTitle.text,
                          controller.date.value,
                          categoryController.categoryList,
                          controller.time.value,
                          txtAmount.text,
                          0
                      );
                    },
                    child: Text(
                      "income",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      DBHelper helper = DBHelper();
                      helper.insertIncameExpens(
                          txtTitle.text,
                          controller.date.value,
                          categoryController.categoryList,
                          controller.time.value,
                          txtAmount.text,
                          1
                      );
                    },
                    child: Text(
                      "expenses",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
