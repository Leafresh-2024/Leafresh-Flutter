import 'package:flutter/material.dart';
import 'reply_form.dart';

class CommunityDetail extends StatelessWidget {
  final Map<String, dynamic> feed;
  final Function(String) onAddComment;

  CommunityDetail({required this.feed, required this.onAddComment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    feed['userimg'] ?? 'https://your-default-image-url.com', // 프로필에도 업로드한 이미지가 나와버림.
                  ),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(feed['username'] ?? 'Unknown'),
              ],
            ),
            SizedBox(height: 10),
            feed['imageUrl'] != null && feed['imageUrl'].isNotEmpty
                ? Image.network(feed['imageUrl'])
                : SizedBox.shrink(), // 이미지가 없을 경우 빈 공간 처리
            SizedBox(height: 10),
            Text(feed['content'] ?? 'No content'),
            SizedBox(height: 10),
            Text('작성일자: ${feed['time'] ?? 'Unknown date'}'),
            Divider(),
            Text('댓글'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: feed['comments'] != null ? feed['comments'].length : 0,
              itemBuilder: (context, index) {
                final comment = feed['comments'][index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      comment['userimg'] != null && comment['userimg'].contains('http')
                          ? comment['userimg']
                          : 'https://your-default-image-url.com',
                    ),
                    radius: 20,
                  ),
                  title: Text(comment['userNickname'] ?? 'Unknown User'),
                  subtitle: Text(comment['replyContent'] ?? 'No content'),
                  trailing: Text(comment['displayDate'] ?? 'Unknown date'),
                );
              },
            ),
            ReplyForm(onAddComment: onAddComment),
          ],
        ),
      ),
    );
  }
}
