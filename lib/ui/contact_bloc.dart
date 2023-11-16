// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mdtt/model/contact.dart';
import 'package:mdtt/model/contact_api.dart';
import 'package:mdtt/model/email_input.dart';
import 'package:mdtt/model/text_input.dart';
import 'package:mdtt/utils/input_validator.dart';
import 'package:bloc/bloc.dart';

abstract class ContactEvent {}

final class ContactNameChanged extends ContactEvent {
  ContactNameChanged(this.name);

  final String name;
}

final class ContactEmailChanged extends ContactEvent {
  ContactEmailChanged(this.email);

  final String email;
}

final class ContactMessageChanged extends ContactEvent {
  ContactMessageChanged(this.message);

  final String message;
}


final class ContactSent extends ContactEvent {
  ContactSent();
}

enum ContactStatus { initial, inProgress, success, failure }

class ContactState {
  const ContactState({
    this.status = ContactStatus.initial,
    this.name = const TextInput.pure(),
    this.email = const EmailInput.pure(),
    this.message = const TextInput.pure(),
  });

  final ContactStatus status;
  final TextInput name;
  final EmailInput email;
  final TextInput message;

  String? get nameValidationError => textValidationErrorToString(name.displayError);
  String? get emailValidationError => emailValidationErrorToString(email.displayError);
  String? get messageValidationError => textValidationErrorToString(message.displayError);

  bool get isAllFieldsValid => name.isValid && email.isValid && message.isValid;

  bool get isContactSentNotInProgress => status != ContactStatus.inProgress;

  bool get canEnableSentButton => isAllFieldsValid && isContactSentNotInProgress;

  ContactState copyWith({
    ContactStatus? status,
    EmailInput? email,
    TextInput? name,
    TextInput? message,
  }) {
    return ContactState(
      status: status ?? this.status,
      email: email ?? this.email,
      name: name ?? this.name,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'ContactState(status: $status, email: $email, name: $name, message: $message)';
  }

  @override
  bool operator ==(covariant ContactState other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.email == email &&
      other.name == name &&
      other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      email.hashCode ^
      name.hashCode ^
      message.hashCode;
  }
}

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(
    {required ContactApi contactApi}
  )  : _contactApi = contactApi,
        super(const ContactState()) {
    on<ContactNameChanged>(_onContactNameChanged);      
    on<ContactEmailChanged>(_onContactEmailChanged);
    on<ContactMessageChanged>(_onContactMessageChanged);      
    on<ContactSent>(_onContactSent);
  }

  final ContactApi _contactApi;

  void _onContactNameChanged(
    ContactNameChanged event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(name: TextInput.dirty(event.name)));
  }

    void _onContactEmailChanged(
    ContactEmailChanged event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(email: EmailInput.dirty(event.email)));
  }

  void _onContactMessageChanged(
    ContactMessageChanged event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(message: TextInput.dirty(event.message)));
  }

  Future<void> _onContactSent(
    ContactSent event,
    Emitter<ContactState> emit,
  ) async {
      emit(state.copyWith(status: ContactStatus.inProgress));
      final contact = Contact(
        name: state.name.value,
        email: state.email.value,
        message: state.message.value
      );
      try {
        await _contactApi.postContact(contact);
        emit(state.copyWith(status: ContactStatus.success),
        );
      } catch (_) {
        emit(state.copyWith(status: ContactStatus.failure));
      }
  } 
}
