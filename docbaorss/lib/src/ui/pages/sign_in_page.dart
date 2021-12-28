import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email, _password;

  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
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
                'Sign In',
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
                  height: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: AppPasswordField(
                        onSaved: (value) => _password = value!,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        validator: InputValidator.multiple([
                          InputValidator.required()!,
                          InputValidator.length(min: 8)!,
                        ]),
                        onChanged: (newValue) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 15.0,
                      ),
                      child: AppButton(
                        text: 'SignIn',
                        onPressed: _signIn,
                        size: const Size(200, 48),
                      ),
                    ),
                    Center(
                      child: Material(
                        child: InkWell(
                          onTap: () => navigateTo(context, const SignUpPage()),
                          child: const Text(
                            "Don't have an account?",
                            style: k16BoldStyle,
                          ),
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

  void _signIn() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidateMode = AutovalidateMode.onUserInteraction);
      return;
    }
    _formKey.currentState!.save();
    $showLoadingDialog(context, 'Signing in');
    try {
      await FirebaseAuthService.signInUser(_email, _password);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      navigateTo(context, const HomePage());
    } catch (e) {
      Navigator.of(context).pop();
      $showErrorDialog(context, e.toString());
    }
  }
}
