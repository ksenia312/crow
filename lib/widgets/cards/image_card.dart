import 'package:flutter/material.dart';
import 'package:frontend/utils/assets_variables.dart';
import '../../utils/indents.dart';
import '../list_tile.dart';
import 'dart:async';

class ImageCard extends StatefulWidget {
  final String headline2;
  final String bodyText;
  final double imageHeight;
  final double listTileHeight;
  final int initImageNum;

  const ImageCard({
    Key? key,
    required this.headline2,
    required this.bodyText,
    this.imageHeight = 150,
    this.listTileHeight = 120,
    this.initImageNum = 1,
  }) : super(key: key);

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
      _imageURL = getAsset(
          AppAssets.images, 'basic_card_bg__${widget.initImageNum}.jpg');
    });
    _controllerOpacity =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _controllerOpacity.reverse();
    });
    _controllerOpacity.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _imgNum < 5 ? _imgNum++ : _imgNum = 1;
          _imageURL = getAsset(AppAssets.images, 'basic_card_bg__') +
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
    return Card(
      margin: AppIndents.basicMargin,
      elevation: 2,
      color: Theme.of(context).colorScheme.secondary,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4), child: _drawContent()),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
        image: DecorationImage(
          opacity: _controllerOpacity.value,
          image: AssetImage(_imageURL),
          fit: BoxFit.cover,
        ),
      );

  Container _drawContent() => Container(
        width: double.infinity,
        decoration: _decoration(),
        child: Column(
          children: [
            SizedBox(
              child: null,
              height: widget.imageHeight,
            ),
            AppListTile(
              headline2: widget.headline2,
              bodyText: widget.bodyText,
              height: widget.listTileHeight,
              color: Theme.of(context).colorScheme.secondary,
              textColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
      );
}
