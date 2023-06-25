import 'package:tech_test/feature/post/controller/post_detail_controller.dart';

class PostDetailArguments {
  PostDetailArguments({this.id, required this.postDetailType});

  final int? id;
  final PostDetailPageType postDetailType;
}
