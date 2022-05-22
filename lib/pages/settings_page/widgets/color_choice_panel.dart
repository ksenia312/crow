import 'package:flutter/cupertino.dart';
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
              height: 200,
              child: Card(
                elevation: 35,
                margin: AppIndents.basicMargin,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CloseButton(
                            color: Theme.of(context).colorScheme.onSecondary),
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
                    )
/*ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CloseButton(
                            onPressed: widget.toggle,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ],
                      ),
                      LayoutGrid(
                        columnSizes: [
                          1.fr,
                          1.fr,
                          1.fr,
                          1.fr,
                        ],
                        rowSizes: [
                          (80).px,
                          (80).px,
                        ],
                        children: _drawBackgroundBoxes(context),
                      ),
                    ],
                  ),*/
                    ),
              ),
            ),
          )
        : Container();
  }

  _drawBackgroundBoxes() {
    return ColorfulThemeType.values.map((type) {
      var num = type.index;
      var _buttonParams = _getColorModeParams(type);
      return Container(
        margin: AppIndents.basicMargin,
        height: double.infinity,
        width: 50,
        color: _buttonParams[0],
        child: GestureDetector(
          onTap: () {
            appTheme.toggleColorMode(num);
          },
        ),
      ); /*AppTextButton(
        buttonText: '',
        onPressed: () {
          appTheme.toggleColorMode(num);
        },
        type: AppTextButtonType.custom,
        size: AppTextButtonSize.scrollable,
        //shape: AppTextButtonShape.circle,
        customBackgroundColor: _buttonParams[0],
        customForegroundColor: _buttonParams[1],
      );*/
    }).toList();
  }
}
