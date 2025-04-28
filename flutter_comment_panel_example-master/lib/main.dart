import 'package:flutter/material.dart';
import 'package:flutter_comment_panel_example/comment/content.view.dart';
import 'package:get/get.dart';

import 'comment/content.binding.dart';
import 'comment/detail/comment_detail.controller.dart';
import 'comment/list/comment_list.binding.dart';
import 'comment/list/comment_list.controller.dart';
import 'comment/list/comment_list.view.dart';
import 'comment/panel/comment_panel.binding.dart';
import 'comment/panel/comment_panel.controller.dart';
import 'comment/panel/comment_panel.view.dart';

void main() {
  // 初始化 GetX 控制器
  // Get.put(CommentPanelController());
  // Get.put(CommentListController());
  // Get.put(CommentDetailController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Comment Panel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/content",
            bindings: [ContentBinding(), ],
            page: () => const ContentPage(),
        children: [
          GetPage(name: "/comment-panel",


              page: () => const CommentPanelView()),
          GetPage(name: "/comment-list", page: () => const CommentListView()),
        ]
        ),
      ],
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed("/content");
           // Get.to(() => const ContentPage());
          },
          child: const Text("to content page"),
        ),
      ),
    );
  }
}


