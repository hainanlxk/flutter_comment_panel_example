import 'package:get/get.dart';

import 'comment_panel.controller.dart';


class CommentPanelBinding extends Bindings {
  @override
  List<Bind> dependencies() => [Bind.lazyPut<CommentPanelController>(() => CommentPanelController())];
}
