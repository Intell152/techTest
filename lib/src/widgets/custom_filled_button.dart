import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CustomFilledButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Color(0xFF204c94)),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(title, maxLines: 2, textAlign: TextAlign.center),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
