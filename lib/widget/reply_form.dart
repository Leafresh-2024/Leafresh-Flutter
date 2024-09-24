import 'package:flutter/material.dart';

class ReplyForm extends StatefulWidget {
  final Function(String) onAddComment;

  ReplyForm({required this.onAddComment});

  @override
  _ReplyFormState createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: '댓글 입력'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            widget.onAddComment(_controller.text);
            _controller.clear();
          },
          child: Text('댓글 작성'),
        ),
      ],
    );
  }
}
