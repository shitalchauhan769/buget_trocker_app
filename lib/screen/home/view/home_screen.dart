import 'package:budgt_trocker/screen/entry/controller/entry_controller.dart';
import 'package:budgt_trocker/screen/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EntryController controller = Get.put(EntryController());
  @override
  void initState() {
   controller.getEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/category");
            },
            icon: Icon(Icons.app_registration),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.entryList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onDoubleTap: () {
                DBHelper helper=DBHelper();
                helper.deleteEntry(controller.entryList[index].id);
                controller.getEntry();
              },
              child: ListTile(
                title: Text(
                  "${controller.entryList[index].category}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${controller.entryList[index].title}",  style: const TextStyle(fontSize: 14)),
                trailing: Text("\$ ${controller.entryList[index].amount}",style: TextStyle(color: controller.entryList[index].status==1?Colors.red:Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/entry');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
