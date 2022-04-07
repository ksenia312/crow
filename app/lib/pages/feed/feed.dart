import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('feed', style: AppTheme.bodyText(context)));
  }
}
