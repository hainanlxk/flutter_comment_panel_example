import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_comment_panel_example/comment/panel/comment_panel.controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../widget/comment_input_widget.dart';
import '../../widget/item_widget.dart';
import '../../widget/write_bottom_widget.dart';
import 'comment_detail.controller.dart';


class CommentDetailPage extends StatefulWidget {
  final String id;

  const CommentDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> with WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();

  bool isShowTextField = false;

  int index = -1;
  
  late CommentPanelController panelModel;
  late CommentDetailController detailModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    panelModel = Get.find<CommentPanelController>();
    detailModel = Get.find<CommentDetailController>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    detailModel.currentNavigatorContext.value = null;
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // delay 300 milliseconds sliding animation is more natural
    if (index != -1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        panelModel.controllerPanel.setScrollEnable(true);
        panelModel.detailSc?.scrollToIndex(index);
      });
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    detailModel.currentNavigatorContext.value = context;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Column(
        children: [
          _buildContentWidget(),
          _buildWriteWidget(),
        ],
      ),
    );
  }

  Widget _buildContentWidget() {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              _buildTopBarWidget(),
              _buildListWidget(),
            ],
          ),
          isShowTextField
              ? InkWell(
                  onTap: () {
                    setShowInput(false);
                  },
                  child: Container(
                    color: const Color(0xff000000).withOpacity(0.4),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _buildTopBarWidget() {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerMove: (p) => panelModel.controllerPanel.onChildWidgetPointerMove(p),
      child: Container(
        height: 57,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  "CommentDetail",
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListWidget() {
    return Expanded(
        child: MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        controller: panelModel.detailSc,
        itemCount: 20,
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => Container(height: 8, color: const Color(0xfff5f5f5)),
      ),
    ));
  }

  Widget _buildItem(int index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: panelModel.detailSc!,
      index: index,
      child: CommentItemWidget(
        index: index,
        isShowMoreBtn: false,
        onClickItem: (index) {
          this.index = index;
          setShowInput(true);
        },
      ),
    );
  }

  Widget _buildWriteWidget() {
    return Stack(
      children: [
        WriteBottomWidget(
          onClick: () => setShowInput(true),
        ),
        isShowTextField
            ? CommentInputWidget(
                controller: textEditingController,
                onCommit: (value) {
                  textEditingController.clear();
                  setShowInput(false);
                },
                onChanged: (value) {},
              )
            : const SizedBox()
      ],
    );
  }

  void setShowInput(bool isShow) {
    panelModel.isDraggable = !isShow;
    isShowTextField = isShow;
    if (mounted) setState(() {});
  }
}
