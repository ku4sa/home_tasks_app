import 'package:formz/formz.dart';

final class Username extends FormzInput<String, String> {
  const Username.pure([super.value = '']) : super.pure();
  const Username.dirty([super.value = '']) : super.dirty();

  static final RegExp regex = RegExp(r'^[a-zA-Z0-9_.]*$');

  @override
  String? validator(String? value) {
    if (value != null && value.length < 3) {
      return "Имя пользователя слишком короткое";
    } else if (value != null && value.length > 32) {
      return "Имя пользователя слишком длинное";
    } else if (value != null && regex.hasMatch(value)) {
      return null;
    } else {
      return "Может содержать только латинницу и символы . _";
    }
  }
}
