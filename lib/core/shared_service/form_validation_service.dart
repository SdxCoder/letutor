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
    MinLengthValidator(7,
      errorText: 'phone no is less than 7 digits long'),
      MaxLengthValidator(8,
      errorText: 'phone no is more than 8 digits long'),
    PatternValidator(r'^[0-9]*$',
        errorText: 'No characters/space allowed')
  ]);

  final emailValidator = MultiValidator([
    _requiredValidator,
    PatternValidator(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        errorText: 'enter a valid email address')
  ]);
  // final emailValidator =
  //     EmailValidator(errorText: 'enter a valid email address');
}
