import 'package:get/get.dart';

import 'content.controller.dart';
import 'detail/comment_detail.controller.dart';
import 'list/comment_list.controller.dart';
import 'panel/comment_panel.controller.dart';

class ContentBinding extends Bindings {
  @override
  List<Bind> dependencies() => [
    Bind.put<CommentDetailController>( CommentDetailController()),
        Bind.lazyPut<CommentPanelController>(() => CommentPanelController()),
        Bind.lazyPut<CommentListController>(() => CommentListController()),

        Bind.lazyPut<ContentController>(() => ContentController()),
      ];
}
