import 'package:flutter/material.dart';
import 'package:frontend/utils/types.dart';
import '../../utils/styles.dart';
import '../list_tile.dart';
import 'dart:async';

class ImageCard extends StatefulWidget {
  final String headline2;
  final String bodyText;
  final double imageHeight;
  final double listTileHeight;
  final int initImageNum;
  final Widget? trailing;

  const ImageCard(
      {Key? key,
      required this.headline2,
      required this.bodyText,
      this.imageHeight = 150,
      this.listTileHeight = 80,
      this.initImageNum = 1,
      this.trailing})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageCardState();
  }
}

class ImageCardState extends State<ImageCard> with TickerProviderStateMixin {
  int _imgNum = 1;
  late String _imageURL;
  late AnimationController _controllerOpacity;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      _imageURL = getAsset(AppAssets.images,
          'card_bg__${widget.initImageNum < 10 ? '0' : ''}${widget.initImageNum}.jpg');
    });
    _controllerOpacity =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _controllerOpacity.reverse();
    });
    _controllerOpacity.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _imgNum = getRandomImageNum();
          _imageURL = getAsset(AppAssets.images, 'card_bg__') +
              (_imgNum < 10 ? '0' : '') +
              _imgNum.toString() +
              '.jpg';
        });
        _controllerOpacity.forward(from: 0);
      }
    });

    _controllerOpacity.addListener(() => setState(() {}));
    _controllerOpacity.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.listTileHeight + widget.imageHeight,
      margin: AppIndents.all5ExceptBottom,
      child: _drawContent(),
    );
  }

  Column _drawContent() => Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4), topLeft: Radius.circular(4)),
            child: Container(
              width: double.infinity,
              height: widget.imageHeight,
              color: Theme.of(context).colorScheme.secondary,
              child: Opacity(
                opacity: _controllerOpacity.value,
                child: Image.asset(
                  _imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4)),
            child: AppListTile(
                headline2: widget.headline2,
                bodyText: widget.bodyText,
                height: widget.listTileHeight,
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.onSecondary,
                trailing: widget.trailing,
                padding: 4.0),
          ),
        ],
      );
}
