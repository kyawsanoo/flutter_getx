import 'package:flutter_getx/constant/route_constant.dart';
import 'package:flutter_getx/screens/list_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> pages = [
  GetPage(
      name: RouteConstant.listScreen,
      page: () =>  const ListScreen(),
      ),
];