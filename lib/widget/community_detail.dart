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
                  backgroundImage: NetworkImage(feed['userimg']),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(feed['username']),
              ],
            ),
            SizedBox(height: 10),
            Image.network(feed['imageUrl']),
            SizedBox(height: 10),
            Text(feed['content']),
            SizedBox(height: 10),
            Text('작성일자: ${feed['time']}'),
            Divider(),
            Text('댓글'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: feed['comments'].length,
              itemBuilder: (context, index) {
                final comment = feed['comments'][index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      feed['userimg'] != null && feed['userimg'].contains('http')
                          ? feed['userimg']
                          : 'https://your-default-image-url.com',
                    ),
                    radius: 20,
                  ),
                  title: Text(comment['userNickname']),
                  subtitle: Text(comment['replyContent']),
                  trailing: Text(comment['displayDate']),
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
