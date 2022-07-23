import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportDeveloper extends StatefulWidget {
  const SupportDeveloper({Key? key}) : super(key: key);

  @override
  State<SupportDeveloper> createState() => _SupportDeveloperState();
}

class _SupportDeveloperState extends State<SupportDeveloper>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true, min: 0.75);
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppIndents.all5ExceptBottom,
      child: ScaleTransition(
        scale: _rotationAnimation,
        child: AppTextButton(
          buttonText: 'поддержать разработчика',
          type: AppTextButtonType.primary,
          margin: EdgeInsets.zero,
          onPressed: () {
            launchUrlString(
                'https://www.tinkoff.ru/rm/nikitina.kseniya53/2lfdh88050',
                mode: LaunchMode.externalNonBrowserApplication);
          },
        ),
      ),
    );
  }
}
