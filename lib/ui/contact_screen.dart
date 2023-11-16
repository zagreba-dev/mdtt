import 'package:flutter/material.dart';
import 'package:mdtt/model/contact_api.dart';
import 'package:mdtt/ui/common/text_styles.dart';
import 'package:mdtt/ui/contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(contactApi: ContactApi()),
      child: const _ContactView()
    );
  }
}

class _ContactView extends StatelessWidget {
  const _ContactView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactBloc, ContactState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ContactStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('success')));
        } else if (state.status == ContactStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('error')));
        } 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact us', style: AppTextStyles.appBar),
          centerTitle: true
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNameInput(),
              _buildEmailInput(),
              _buildMessageInput(),
              _buildSendButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return Builder(
      builder: (context) {
        final model = context.watch<ContactBloc>();
        final isValid = model.state.name.isValid;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, top: 12, end: 24),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: AppTextStyles.label,
              icon: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/lock.png')
              ),
              helperText: '',
              errorText: isValid ? null : model.state.nameValidationError,
            ),
            onChanged: (value) => context.read<ContactBloc>().add(ContactNameChanged(value))
          ),
        );
      }
    );
  }

  Widget _buildEmailInput() {
    return Builder(
      builder: (context) {
        final model = context.watch<ContactBloc>();
        final isValid = model.state.email.isValid;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, top: 12, end: 24),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: AppTextStyles.label,
              icon: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/lock.png')
              ),
              helperText: '',
              errorText: isValid ? null : model.state.emailValidationError,
            ),
            onChanged: (value) => context.read<ContactBloc>().add(ContactEmailChanged(value))
          ),
        );
      }
    );
  }


  Widget _buildMessageInput() {
    return Builder(
      builder: (context) {
        final model = context.watch<ContactBloc>();
        final isValid = model.state.message.isValid;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, top: 12, end: 24, bottom: 12),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: AppTextStyles.label,
              icon: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/lock.png')),
              helperText: '',
              errorText: isValid ? null : model.state.messageValidationError,
            ),
            onChanged: (value) => context.read<ContactBloc>().add(ContactMessageChanged(value))
          ),
        );
      }
    );
  }

  Widget _buildSendButton() {
    return Builder(
      builder: (context) {
        final model = context.watch<ContactBloc>();
        final isContactSentNotInProgress = model.state.isContactSentNotInProgress;
        final canEnableSentButton = model.state.canEnableSentButton;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, top: 24, end: 24),
          child: FilledButton(
            onPressed: 
              canEnableSentButton 
              ? () {context.read<ContactBloc>().add(ContactSent());} 
              : null, 
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
              child: 
                isContactSentNotInProgress 
                ? const Text("Send", style: AppTextStyles.sendButton) 
                : const Text('please wait', style: AppTextStyles.sendButton),
            )
          ),
        );
      }
    );
  }
}