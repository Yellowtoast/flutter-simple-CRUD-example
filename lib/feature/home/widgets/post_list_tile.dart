import 'package:flutter/material.dart';
import 'package:tech_test/data/model/post.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.onTapPost,
    required this.post,
  });

  final void Function(int) onTapPost;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapPost.call(post.id),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: -1,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.title,
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.star_outline),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                post.textBody,
                // softWrap: false,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(post.authorName),
            const SizedBox(
              height: 5,
            ),
            Text(post.createdAt.toLocal().toString()),
          ],
        ),
      ),
    );
  }
}
