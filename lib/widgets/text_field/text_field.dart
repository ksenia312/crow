import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool obscuringCharacter;
  final Function? onChanged;
  final Function? validator;
  final Function? onEditingComplete;
  final Function? onCloseButtonPressed;

  const AppTextField(
      {required this.hintText,
      this.obscuringCharacter = false,
      this.onChanged,
      this.validator,
      this.onEditingComplete,
      this.onCloseButtonPressed,
      Key? key})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.inputMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          //color: Theme.of(context).colorScheme.tertiary,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),

          child: TextFormField(
            onChanged: (value) {
              widget.onChanged != null ? widget.onChanged!(value) : null;
            },
            obscureText: widget.obscuringCharacter,
            obscuringCharacter: '♡',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.apply(color: Theme.of(context).colorScheme.onTertiary),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
            ),
            cursorColor: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
