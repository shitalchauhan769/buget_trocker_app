import 'package:budgt_trocker/screen/category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/db_helper.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtAlertCategory = TextEditingController();
  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    controller.getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: txtCategory,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "category"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DBHelper helper = DBHelper();
                        await helper.insertCategory(txtCategory.text);
                        controller.getCategory();
                      },
                      child: const Text("submit to category"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text("${controller.categoryList[index].name!}"),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                txtAlertCategory.text =
                                    controller.categoryList[index].name!;
                                Get.defaultDialog(
                                  title: "Update",
                                  content: TextField(
                                    controller: txtAlertCategory,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Category"),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await controller.helper.updateCategory(
                                            txtAlertCategory.text,
                                            controller.categoryList[index].id!);
                                        controller.getCategory();
                                        Get.back();
                                      },
                                      child: const Text("Save"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Get.back();
                                      },
                                      child: const Text("cancel"),
                                    ),
                                  ],
                                );
                                controller.getCategory();
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await controller.helper.deleteCategory(
                                    controller.categoryList[index].id!);
                                controller.getCategory();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
