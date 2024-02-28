import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minsait_tech_test/src/blocs/profile/profile_cubit.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String text;
  final Function onChange;

  const CustomTextField({
    required this.label,
    required this.text,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit();

    profileCubit.textEditingController.text = text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: profileCubit.textEditingController,
          style: const TextStyle(color: Colors.white),
          maxLines: null,
          maxLength: label == 'Escribe tu Reseña:' ? 100 : null,
          inputFormatters: <TextInputFormatter>[
            label == 'Fecha de Registro:'
                ? FilteringTextInputFormatter.allow(RegExp(r'[0-9--]'))
                : FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\sñÑ]')),
            label == 'Teléfono:'
                ? FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                : FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\sñÑ]')),
            label == 'Fecha de Registro:' || label == 'Teléfono:'
                ? LengthLimitingTextInputFormatter(10)
                : LengthLimitingTextInputFormatter(100),
          ],
          decoration: const InputDecoration(
            // hintText: text,
            hintStyle: TextStyle(color: Colors.grey),

            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          onChanged: (value) => onChange(value),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
