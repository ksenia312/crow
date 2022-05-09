import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/utils/color_schemes.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/buttons.dart';

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
        ? [light.background, light.onBackground]
        : [dark.primary, dark.onPrimary];
  }

  List _getColorModeParams(context, ColorfulThemeType colorMode) {
    var _isLight = Theme.of(context).brightness == Brightness.light;
    switch (colorMode) {
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
              height: 240,
              child: Card(
                elevation: 35,
                margin: AppIndents.basicMargin,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
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
                        rowSizes: [(80).px],
                        children: _drawBackgroundBoxes(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  _drawBackgroundBoxes(context) {
    return ColorfulThemeType.values.map((type) {
      var _buttonParams = _getColorModeParams(context, type);
      return AppTextButton(
        buttonText: '',
        onPressed: () {
          currentTheme.toggleColorMode(type);
        },
        type: AppTextButtonType.custom,
        size: AppTextButtonSize.small,
        //shape: AppTextButtonShape.circle,
        customBackgroundColor: _buttonParams[0],
        customForegroundColor: _buttonParams[1],
      );
    }).toList();
  }
}
