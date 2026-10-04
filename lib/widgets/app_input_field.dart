import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A form-compatible field. The caller owns the controller and focus node.
class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.autofillHints,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).colorScheme.secondary,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      obscureText: obscureText,
      autocorrect: !obscureText,
      enableSuggestions: !obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
