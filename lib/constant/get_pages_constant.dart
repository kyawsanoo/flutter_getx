import 'package:flutter_getx/constant/route_constant.dart';
import 'package:flutter_getx/screens/create_todo_screen.dart';
import 'package:flutter_getx/screens/edit_todo_screen.dart';
import 'package:flutter_getx/screens/todo_list_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> pages = [
  GetPage(
      name: RouteConstant.todoListScreen,
      page: () =>  const TodoListScreen(),
      ),
  GetPage(
    name: RouteConstant.createTodoScreen,
    page: () =>  const CreateTodoScreen(),
  ),

  GetPage(
    name: RouteConstant.editTodoScreen,
    page: () =>  const EditTodoScreen(),
  ),
];