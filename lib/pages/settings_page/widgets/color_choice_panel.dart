import 'package:flutter/material.dart';
import 'package:frontend/utils/color_schemes.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/utils/theme.dart';

class ColorChoicePanel extends StatefulWidget {
  final void Function()? toggle;
  final bool pressed;

  const ColorChoicePanel(
      {required this.pressed, required this.toggle, Key? key})
      : super(key: key);

  @override
  State<ColorChoicePanel> createState() => _ColorChoicePanelState();
}

class _ColorChoicePanelState extends State<ColorChoicePanel> {
  List _listColorModeParams(bool isLight, ColorScheme light, ColorScheme dark) {
    return isLight
        ? [light.surface, light.onBackground]
        : [dark.primary, dark.onPrimary];
  }

  List _getColorModeParams(ColorfulThemeType colorMode) {
    var _isLight = Theme.of(context).brightness == Brightness.light;
    switch (colorMode) {
      case ColorfulThemeType.grey:
        return _listColorModeParams(
            _isLight, AppColorScheme.lightGrey, AppColorScheme.darkGrey);
      case ColorfulThemeType.blue:
        return _listColorModeParams(
            _isLight, AppColorScheme.lightBlue, AppColorScheme.darkBlue);
      case ColorfulThemeType.pink:
        return _listColorModeParams(
            _isLight, AppColorScheme.lightPink, AppColorScheme.darkPink);
      case ColorfulThemeType.green:
        return _listColorModeParams(
            _isLight, AppColorScheme.lightGreen, AppColorScheme.darkGreen);
      case ColorfulThemeType.orange:
        return _listColorModeParams(
            _isLight, AppColorScheme.lightOrange, AppColorScheme.darkOrange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.pressed
        ? Center(
            child: SizedBox(
              height: 170,
              child: Card(
                elevation: 35,
                margin: AppIndents.all5ExceptBottom,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CloseButton(
                        onPressed: widget.toggle,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      Expanded(
                        child: CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // конте
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(0.0),
                              sliver: SliverList(
                                delegate: SliverChildListDelegate(
                                    _drawBackgroundBoxes()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  _drawBackgroundBoxes() {
    return ColorfulThemeType.values.map((type) {
      var _colorModeNum = type.index;
      var _buttonParams = _getColorModeParams(type);
      bool _focused = appTheme.currentColorModeNum == _colorModeNum;
      return Container(
        margin: AppIndents.all5ExceptBottom,
        height: double.infinity,
        width: 50,
        decoration: BoxDecoration(color: _buttonParams[0], boxShadow: [
          _focused
              ? BoxShadow(
                  blurRadius: 5, color: Theme.of(context).colorScheme.shadow)
              : const BoxShadow()
        ]),
        child: GestureDetector(
          child: _focused
              ? Icon(Icons.check,
                  size: 30, color: Theme.of(context).colorScheme.onPrimary)
              : null,
          onTap: () {
            appTheme.toggleColorMode(_colorModeNum);
          },
        ),
      );
    }).toList();
  }
}
