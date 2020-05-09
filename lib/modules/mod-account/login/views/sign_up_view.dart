import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:letutor/modules/mod-account/login/view_models/auth_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/core.dart';
import 'auth_view.dart';
import 'form_card.dart';

class CustomIcons {
  static const IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  static const IconData googlePlus =
      IconData(0xe902, fontFamily: "CustomIcons");
  static const IconData linkedin = IconData(0xe800, fontFamily: "CustomIcons");
}

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final rPassController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _password;
  DateTime _dateTime;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    rPassController.dispose();
    super.dispose();
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, AuthViewModel model, child) => AuthView(
        model: model,
        formCard: _signUpForm(model),
        authButton: raisedButton(
            btnText: "Register",
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await model.signUpWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passController.text.trim(),
                  dob: _dateTime.toUtc(),
                  firstName: fNameController.text.trim(),
                  lastName: lNameController.text.trim(),
                  phoneNo: phoneNoController.text.trim()
                  
                );
              }
            }),
        navigatorButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Have an Account: ",
                style: TextStyle(fontFamily: "Poppins-Medium")),
            InkWell(
              onTap: () {
                Modular.to.pushNamed(Routes.login);
              },
              child: Text("Log-In",
                  style: TextStyle(
                      color: Color(0xFF5d74e3), fontFamily: "Poppins-Bold")),
            )
          ],
        ),
      ),
    );
  }

  Widget _signUpForm(AuthViewModel model) {
    return Form(
      key: _formKey,
      child: FormCard(
        widgets: <Widget>[
          Text("Register",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(45),
                  fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Fisrt Name",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: fNameController,
            keyboardType: TextInputType.text,
            validator: model.validationService.nameValidator,
            decoration: InputDecoration(
                hintText: "First Name",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
           SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Last Name",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: lNameController,
             keyboardType: TextInputType.text,
            validator: model.validationService.nameValidator,
            decoration: InputDecoration(
                hintText: "Last Name",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Email",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: emailController,
            validator: model.validationService.emailValidator,
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Password",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            obscureText: true,
            controller: passController,
            validator: model.validationService.passwordValidator,
            onChanged: (val) {
              _password = val;
             
            },
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Re-Password",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            obscureText: true,
            controller: rPassController,
            validator: (val) {
              print(val);
              print(_password);
              return MatchValidator(errorText: 'passwords do not match')
                  .validateMatch(val, _password);
            },
            decoration: InputDecoration(
                hintText: "Re-Password",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
           SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text("Phone No",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil().setSp(26))),
          TextFormField(
            controller: phoneNoController,
            keyboardType: TextInputType.number,
            validator: model.validationService.phoneValidator,
            decoration: InputDecoration(
                hintText: "Phone No",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(35),
          ),
          Row(
            children: <Widget>[
              Text((_dateTime == null) ? "Date of Birth" : (_dateTime.dob),
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil().setSp(26))),
              Spacer(),
              FlatButton(onPressed: (){
                _showDatePicker(model);
              }, child: Text("Select"))
            ],
          ),
         
          SizedBox(
            height: ScreenUtil().setHeight(35),
          ),
        ],
      ),
    );
  }

  void _showDatePicker(AuthViewModel model) {
    const String MIN_DATETIME = '1900-05-12';
    const String INIT_DATETIME = '2014-06-15';
    String _format = 'yyyy-MMMM-dd';

    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: false,
      minuteDivider: 1,
      pickerTheme: DateTimePickerTheme(
        itemHeight: 50,

        pickerHeight: MediaQuery.of(context).size.height*0.5,
        // title: Text("Select Date", style: Theme.of(context).textTheme.headline5.copyWith(
        //   color:Colors.black
        // ),),
        showTitle: true,
        confirm: Text('Confirm', style: TextStyle(color: Colors.cyan)),
        cancel: Text('Cancel', style: TextStyle(color: Colors.red)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.now(),
      initialDateTime: DateTime.parse(INIT_DATETIME),
      dateFormat: _format,
      locale: DateTimePickerLocale.en_us,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        print(dateTime.toString());
      },
      onConfirm: (dateTime, List<int> index) {
        
          setState(() {
            _dateTime = dateTime;
          });
           
       
      },
    );
  }
}
