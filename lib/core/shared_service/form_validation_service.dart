import 'package:form_field_validator/form_field_validator.dart';

class FormValidationService {
  static final _requiredValidator =
      RequiredValidator(errorText: 'this field is required');
  static final _lengthValidator = MinLengthValidator(8,
      errorText: 'password must be at least 8 digits long');

  final passwordValidator = MultiValidator([
    _requiredValidator,
    _lengthValidator,
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'passwords must have at least one special character')
  ]);

  final nameValidator = MultiValidator([
    _requiredValidator,
    // PatternValidator(r'(^[a-z],[A-Z]$)',
    //     errorText: 'only alphabets allowed')
  ]);

  final phoneValidator = MultiValidator([
    _requiredValidator,
    MinLengthValidator(10,
      errorText: 'phone no is less than 10 digits long'),
      MaxLengthValidator(12,
      errorText: 'max 12 digits long in case of country code'),
    PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
        errorText: 'No space or no characters allowed between digits')
  ]);

  final emailValidator = MultiValidator([
    _requiredValidator,
    PatternValidator(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        errorText: 'enter a valid email address')
  ]);
  // final emailValidator =
  //     EmailValidator(errorText: 'enter a valid email address');
}
