import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_comment_panel_example/comment/panel/comment_panel.controller.dart';
import 'package:flutter_comment_panel_example/comment/panel/comment_panel.view.dart';

import 'content.controller.dart';
import 'detail/comment_detail.controller.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPanelPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<ContentController>(builder: (_) {
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'content',
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Get.find<CommentPanelController>().open("adb");
                      },
                      child: const Icon(Icons.edit_note),
                    )
                  ],
                ),
              ),
              const CommentPanelView()
            ],
          );
        }),
      ),
    );
  }

  Future<bool> _willPanelPop() async {
    // Existence details page partial route pops up to the initial page
    CommentDetailController detailModel = Get.find<CommentDetailController>();
    if (detailModel.currentNavigatorContext.value != null) {
      Navigator.popUntil(
          detailModel.currentNavigatorContext.value!, (route) => route.isFirst);
      return false;
    }
    // If the comment panel is open, close it
    CommentPanelController panelModel = Get.find<CommentPanelController>();
    if (panelModel.controllerPanel.isPanelOpen) {
      panelModel.controllerPanel.close();
      return false;
    }

    return true;
  }
}
