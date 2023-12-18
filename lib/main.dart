import 'package:flutter/material.dart';
import 'package:flutter_getx/constant/get_pages_constant.dart';
import 'package:flutter_getx/constant/route_constant.dart';
import 'package:get/get.dart';

import 'providers/TodoProvider.dart';

void main() async {
  Get.put(TodoProvider());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      initialRoute: RouteConstant.todoListScreen,
      getPages: pages,
    );
  }
}
