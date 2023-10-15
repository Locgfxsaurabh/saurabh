import 'package:flutter/cupertino.dart';

class TextFieldUnFocusOnTap extends StatelessWidget {
  final Widget child;
  const TextFieldUnFocusOnTap({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
