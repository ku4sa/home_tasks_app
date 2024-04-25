import 'package:formz/formz.dart';

final class Search extends FormzInput<String, String> {
  const Search.pure([super.value = '']) : super.pure();
  const Search.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return null;
  }
}
