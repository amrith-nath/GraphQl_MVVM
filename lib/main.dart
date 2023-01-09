import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql/view_model/controllers/graph_controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'view/home/screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  Get.put(GraphController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'graphQl Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'GraphQL',
      ),
    );
  }
}
