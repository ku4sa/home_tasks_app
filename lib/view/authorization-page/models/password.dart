import 'package:formz/formz.dart';

final class Password extends FormzInput<String, String> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  static final RegExp regex =
      RegExp(r'''^[ a-zA-Z0-9_.!'"#$%&(),+-:;/<\=>?@`{|}~^*\/\[\]\\]*$''');

  @override
  String? validator(String? value) {
    if (value == null || value.length < 8) {
      return "Слишком короткий пароль";
    } else if (value.length > 255) {
      return "Слишком длинный пароль";
    } else if (!regex.hasMatch(value)) {
      return 'Пароль может содержать только [! " # \$ %  & \' ( ) * , +  - . / : ; < = > ? @ [ \\ ] ^ _` { | } ~].';
    } else {
      return null;
    }
  }
}
