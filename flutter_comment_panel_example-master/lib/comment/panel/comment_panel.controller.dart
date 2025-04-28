import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../sliding_up_panel/panel.dart';
import '../list/comment_list.controller.dart';


class CommentPanelController extends GetxController {
  PanelController controllerPanel = PanelController();

  AutoScrollController? listSc = AutoScrollController();
  AutoScrollController? detailSc = AutoScrollController();

  final _isDraggable = true.obs;

  Rx<String?> id = Rx<String?>(null);

  void init() {
    listSc = AutoScrollController();
    detailSc = AutoScrollController();
  }

  void clear() {
    controllerPanel.clear();
    listSc?.dispose();
    detailSc?.dispose();
    listSc = null;
    detailSc = null;
  }

  void open(String newId) {
    id.value = newId;
    update();
    controllerPanel.open();

    Get.findOrNull<CommentListController>()?.init();
  }

  void setPanelScToList() {
    controllerPanel.setScrollController(listSc!);
  }

  void setPanelScToDetail() {
    controllerPanel.setScrollController(detailSc!);
  }

  bool get isDraggable => _isDraggable.value;

  set isDraggable(bool value) {
    _isDraggable.value = value;
    update();
  }
}
