// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contact {
  final String name;
  final String email;
  final String message;
  
  Contact({
    required this.name,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'email': email,
    'message': message,
  };

  @override
  String toString() => 'Contact(name: $name, email: $email, message: $message)';
}

