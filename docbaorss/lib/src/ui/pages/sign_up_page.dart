import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _validation = AutovalidateMode.disabled;
  var _password1 = '';
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _validation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Hero(
                  tag: 'logo',
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                    size: 130,
                  ),
                ),
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Hero(
                tag: 'Container',
                child: Container(
                  width: double.infinity,
                  height: 455,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 30.0,
                  ),
                  child: Column(children: [
                    AppTextField(
                      iconData: CupertinoIcons.mail,
                      onSaved: (value) => _email = value!,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      validator: InputValidator.email(
                          message: 'Email must not be empty'),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    AppPasswordField(
                      onSaved: (value) => _password1 = value!,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      validator: InputValidator.multiple([
                        InputValidator.required()!,
                        InputValidator.length(min: 8)!,
                      ]),
                      onChanged: (newValue) => _password1 = newValue ?? '',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: AppPasswordField(
                        onSaved: (value) => _password = value!,
                        labelText: 'Confirm Password',
                        hintText: 'Repeat Password',
                        validator: (value) {
                          String? _msg;
                          if (value?.isEmpty ?? true) {
                            _msg = 'Field must not be empty';
                          } else {
                            if (value != _password1) {
                              _msg = 'Password did mot matched';
                            }
                          }
                          return _msg;
                        },
                        onChanged: (String? newValue) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 15.0,
                      ),
                      child: AppButton(
                        text: 'SignUp',
                        onPressed: _signUp,
                        size: const Size(200, 48),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: Navigator.of(context).pop,
                        child: const Text(
                          "Already have an account",
                          style: k16BoldStyle,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _validation = AutovalidateMode.onUserInteraction);
      return;
    }
    $showLoadingDialog(context, 'Registering');
    _formKey.currentState!.save();
    try {
      await FirebaseAuthService.signUpUser(_email, _password);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      navigateTo(context, const HomePage());
    } catch (e) {
      Navigator.of(context).pop();
      $showErrorDialog(context, e.toString());
    }
  }
}
