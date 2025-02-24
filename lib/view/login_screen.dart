import 'package:flutter/material.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
            SizedBox(height: height * .1,),
          ]
        ),
      )


      // body: Center(
      //   child: InkWell(
      //       onTap: (){
      //         Utils.snackBar('This is SnackBar', context);
      //         Utils.flushBarErrorMessage('No Internet Connection', context);
      //         Utils.toastMessage('this is toast message');
      //
      //         //Navigator.pushNamed(context, RoutesName.home);
      //         //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      //       },
      //       child: Text('Click')),
      // )
    );
  }
}