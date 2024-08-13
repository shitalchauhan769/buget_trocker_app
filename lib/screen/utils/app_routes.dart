import 'package:budgt_trocker/screen/category/view/category_screen.dart';
import 'package:budgt_trocker/screen/entry/view/entry_screen.dart';
import 'package:budgt_trocker/screen/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> app_routes = {
  '/': (c1) => const HomeScreen(),
  '/entry': (c1) => const EntryScreen(),
  '/category': (c1) => const CategoryScreen(),
};
