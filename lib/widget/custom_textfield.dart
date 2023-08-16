import 'package:flutter/material.dart';

import '../utils/app_strings.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? textLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isVisiblePassword;
  final bool? enabled;

  const CustomTextField({
    super.key,
    this.labelText,
    this.textInputType,
    this.textInputAction,
    this.textLength,
    this.prefixIcon,
    this.suffixIcon,
    this.isVisiblePassword,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      maxLength: textLength,
      obscureText: isVisiblePassword ?? false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        labelText: labelText ?? "",
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: (value) {
        final data = value!;
        if (data.isEmpty) {
          return "Required field";
        } else if (textInputType == TextInputType.number) {
          if (data.length != 10) {
            return "Enter valid mobile";
          } else if (data.compareTo(AppStrings.eVitalRXPhone) != 0) {
            return "Phone should be match";
          }
        } else if (textInputType == TextInputType.visiblePassword) {
          if (data.compareTo(AppStrings.eVitalRXPassword) != 0) {
            return "Password should be match";
          }
        }

        return null;
      },
    );
  }
}
