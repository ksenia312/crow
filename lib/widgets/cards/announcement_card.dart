import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/list_tile.dart';

class AnnouncementCard extends StatefulWidget {
  final String headline2;
  final String? bodyText;
  final double? height;
  final bool showCloseButton;

  const AnnouncementCard(
      {Key? key,
      required this.headline2,
      required this.bodyText,
      this.height = 78,
      this.showCloseButton = true})
      : super(key: key);

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool _show = true;

  void close() {
    setState(() {
      _show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_show) {
      return Card(
          margin: AppIndents.basicMargin,
          color: Theme.of(context).colorScheme.primary,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AppListTile(
                trailing: widget.showCloseButton
                    ? CloseButton(
                        color: Theme.of(context).colorScheme.onPrimary,
                        onPressed: close,
                      )
                    : null,
                padding: 4.0,
                headline2: widget.headline2,
                bodyText: widget.bodyText,
                height: widget.height,
                textColor: Theme.of(context).colorScheme.onPrimary,
                color: Theme.of(context).colorScheme.primary,
              )));
    } else {
      return Container();
    }
  }
}
