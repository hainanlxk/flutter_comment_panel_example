import 'package:get/get.dart';

import 'comment_list.controller.dart';


class CommentListBinding extends Bindings {
  @override
  List<Bind> dependencies() => [Bind.lazyPut<CommentListController>(() => CommentListController())];
}
