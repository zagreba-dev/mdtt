import 'package:mdtt/model/email_input.dart';
import 'package:mdtt/model/text_input.dart';

String? emailValidationErrorToString(EmailValidationError? type) {
  switch(type) {
    case EmailValidationError.required: return 'required';
    case EmailValidationError.invalid: return 'invalid';
    default: return null;
  }
}

String? textValidationErrorToString(TextValidationError? type) {
  switch(type) {
    case TextValidationError.required: return 'required';
    default: return null;
  }
}