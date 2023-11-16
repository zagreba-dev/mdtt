import 'package:formz/formz.dart';

enum TextValidationError {
  required,
}

class TextInput extends FormzInput<String, TextValidationError> {
  const TextInput.pure() : super.pure('');

  const TextInput.dirty([super.value = '']) : super.dirty();

  @override
  TextValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return TextValidationError.required;
    return null;
  }
}