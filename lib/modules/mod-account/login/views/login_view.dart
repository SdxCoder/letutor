import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-account/login/view_models/auth_view_model.dart';
import 'package:letutor/modules/mod-account/login/views/auth_view.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/core.dart';
import 'form_card.dart';

class CustomIcons {
  static const IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  static const IconData googlePlus =
      IconData(0xe902, fontFamily: "CustomIcons");
  static const IconData linkedin = IconData(0xe800, fontFamily: "CustomIcons");
}

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
  
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
        formCard: _loginForm(model),
        authButton: raisedButton(
            btnText: "Login",
            onPressed: () {
              if (_formKey.currentState.validate()) {
                model.signInWithEmailAndPassword(
                    emailController.text.trim(), passController.text.trim());
              }
            }),
        navigatorButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("If new user: ",
                style: TextStyle(fontFamily: "Poppins-Medium")),
            InkWell(
              onTap: () {
                Modular.to.pushNamed(Routes.signup);
              },
              child: Text("Register",
                  style: TextStyle(
                      color: Color(0xFF5d74e3), fontFamily: "Poppins-Bold")),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _loginForm(AuthViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Form(
        key: _formKey,
        child: FormCard(
          widgets: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
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
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    String email = await _showEmailDialog(context, model);
                    if(email != null){
                      await model.sendPasswordResetEmail(email);
                    }else{
                      print("cancelled");
                    }
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _showEmailDialog(context, model) async {
    String email;
    return showDialog<String>(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              width: 500,
              margin: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password Reset",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                   
                    TextFormField(
                      //controller: emailController,
                     // validator: model.validationService.emailValidator,
                      onChanged: (val) {
                        email = val;
                        print(email);
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonBar(children: [
                      
                      FlatButton(
                        onPressed: () {
                          return Modular.to.pop(null);
                        },
                        child: Text("Cancel"),
                      ),
                      raisedButton(
                        btnText: "Submit",
                        onPressed: () {
                           return Modular.to.pop(email);
                        },
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          );
        });
  }
}
