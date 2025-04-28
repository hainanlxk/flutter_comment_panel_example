
import 'package:flutter_comment_panel_example/comment/panel/comment_panel.controller.dart';
import 'package:get/get.dart';


class CommentListController extends GetxController {
  // 使用 GetX 的响应式变量
  final RxList<String> list = <String>[].obs;

  void init() {
    CommentPanelController model = Get.find<CommentPanelController>();
    model.setPanelScToList();
    _request();
  }

  Future<void> _request() async {
    await Future.delayed(const Duration(milliseconds: 100));
    list.clear();
    for (int i = 0; i < 20; i++) {
      list.add(i.toString());
    }
    update(); // 通知 UI 更新
  }
}