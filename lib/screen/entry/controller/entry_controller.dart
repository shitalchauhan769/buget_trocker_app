import 'package:budgt_trocker/screen/entry/model/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/db_helper.dart';

class EntryController extends GetxController
{
  DBHelper helper =DBHelper();
  Rx<DateTime> date= DateTime.now().obs;
  Rx<TimeOfDay> time=TimeOfDay.now().obs;
  RxnString selectCategory=RxnString();
  RxList<EntryModel>entryList=<EntryModel>[].obs;
  List<EntryModel>filterList=[];


  Future<void> getEntry() async {
    entryList.value = await helper.readEntry();
  }


  Future<void> getStutseDate(int? status) async {
    entryList.value =await helper.sharChing(status);
  }

  void searchingData(String search)
  {
    List<EntryModel>brekateList=[];

    for(var x in entryList)
      {
        if(x.category!.toLowerCase().contains(search.toLowerCase()))
          {
            filterList.add(x);
          }
        entryList.value = filterList;
      }

  }
}