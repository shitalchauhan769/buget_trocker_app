import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryController extends GetxController
{
  Rx<DateTime> date= DateTime.now().obs;
  Rx<TimeOfDay> time=TimeOfDay.now().obs;
  RxnString selectCategory=RxnString();
}