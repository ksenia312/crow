import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final bool obscuringCharacter;
  final bool autofocus;
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
      this.initialValue,
      this.autofocus = false,
      Key? key})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _textEditingController;
  String _value = '';

  @override
  void initState() {
    setState(() {
      _value = widget.initialValue ?? '';
    });
    _textEditingController = TextEditingController(text: _value);
    super.initState();
  }

  _onChanged(value) {
    widget.onChanged != null ? widget.onChanged!(value) : null;
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.vertical10Horizontal20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          //color: Theme.of(context).colorScheme.tertiary,
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.secondaryContainer),

          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: _onChanged,
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
                  controller: _textEditingController,
                  cursorColor: Theme.of(context).colorScheme.onTertiary,
                  autofocus: widget.autofocus,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _textEditingController.clear();
                    _onChanged('');
                  },
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
