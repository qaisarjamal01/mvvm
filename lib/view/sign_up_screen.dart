import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _obsecurePassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email_outlined)
                  ),
                  onFieldSubmitted: (value){
                    Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                  },
                ),
                ValueListenableBuilder(valueListenable: _obsecurePassword,
                    builder: (context,value,child){
                      return TextFormField(
                        controller: _passwordController,
                        focusNode: passwordFocusNode,
                        obscureText: _obsecurePassword.value,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            label: const Text('password'),
                            prefixIcon: const Icon(Icons.lock_open_outlined),
                            suffixIcon: InkWell(
                                onTap: (){
                                  _obsecurePassword.value = ! _obsecurePassword.value;
                                },
                                child: Icon(_obsecurePassword.value? Icons.visibility_off_outlined:Icons.visibility))
                        ),
                      );
                    }
                ),
                SizedBox(height: height * .085,),
                RoundButton(title: 'Sign Up',
                    loading: authViewModel.signUpLoading,
                    onPress: (){
                      if(_emailController.text.isEmpty){
                        Utils.flushBarErrorMessage('Please enter your email', context);
                        //Utils.snackBar('Please enter your email', context);
                        //Utils.toastMessage('Please enter your email');
                      }else if(_passwordController.text.isEmpty){
                        Utils.flushBarErrorMessage('Please enter your password', context);
                      }else if(_passwordController.text.length < 6){
                        Utils.flushBarErrorMessage('Please enter 6 digit password', context);
                      }else{

                        Map data = {
                          'email': _emailController.text.toString(),
                          'password': _passwordController.text.toString(),
                        };

                        authViewModel.signUpApi(data, context);
                        if (kDebugMode) {
                          print('Api hits');
                        }
                      }
                    }),
                SizedBox(height: height * .02,),
                InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.logIn);
                    },
                    child:const Text("Already have an account? Login"))
              ]
          ),
        )
    );
  }
}