import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_comment_panel_example/comment/detail/comment_detail.controller.dart';
import 'package:flutter_comment_panel_example/comment/list/comment_list.view.dart';
import 'package:flutter_comment_panel_example/comment/panel/comment_panel.controller.dart';

import '../../sliding_up_panel/panel.dart';


class CommentPanelView extends StatefulWidget {
  const CommentPanelView({Key? key}) : super(key: key);

  @override
  State<CommentPanelView> createState() => _CommentPanelViewState();
}

class _CommentPanelViewState extends State<CommentPanelView> {
  final GlobalKey _key = GlobalKey();
   CommentPanelController controller=Get.find<CommentPanelController>();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double height = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 60;
    
    return GetBuilder<CommentPanelController>(
      builder: (_) {
        return SlidingUpPanel(
          minHeight: 0,
          maxHeight: height,
          parallaxEnabled: false,
          defaultPanelState: PanelState.CLOSED,
          controller: controller.controllerPanel,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          panelBuilder: (sc) => _buildPanelWidget(sc),
          backdropEnabled: true,
          isDraggable: controller.isDraggable,
          onPanelClosed: () {
            // If there are comment details in the panel, the local route pops up
            // For example, pull down the details page, close the panel, and exit to the list page
            CommentDetailController detailModel = Get.find<CommentDetailController>();
            if (detailModel.currentNavigatorContext.value != null) {
              Navigator.popUntil(detailModel.currentNavigatorContext.value!, (route) => route.isFirst);
            }
          },
        );
      }
    );
  }

  Widget _buildPanelWidget(ScrollController sc) {
    return Navigator(
      key: _key,
      pages: const [
        CupertinoPage(child: CommentListView()),
      ],
      observers: [CommentDetailNavigator()],
      onPopPage: (Route<dynamic> route, dynamic result) {
        return route.didPop(result);
      },
    );
  }
}

class CommentDetailNavigator extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Get.findOrNull<CommentPanelController>()?.isDraggable = true;
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Get.findOrNull<CommentPanelController>()?.isDraggable = false;
    Get.findOrNull<CommentPanelController>()?.controllerPanel.panelPosition = 1.0;
  }

  @override
  void didStopUserGesture() {
    Get.findOrNull<CommentPanelController>()?.isDraggable = true;
  }
}
