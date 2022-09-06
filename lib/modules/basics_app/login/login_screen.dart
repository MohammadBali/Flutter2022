import 'package:flutter/material.dart';
import 'package:newflutter_2022/shared/components/components.dart';

class login_screen extends StatefulWidget {


   login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  var emailController= TextEditingController();

  var passController= TextEditingController();

  var formKey= GlobalKey<FormState>();

  bool isObscure=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Login Page', textAlign: TextAlign.center,),
        backgroundColor: Colors.amber.withOpacity(0.5),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.0,),

                  Text(
                      'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  SizedBox(height: 15,),

                  //Email Address Field
                  defaultFormField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Icons.email,
                    onSubmit: (value) {
                      print('Email Submit' + ' ' + value);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email  is empty';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  //Password Field.
                  defaultFormField(
                      controller: passController,
                      keyboard: TextInputType.text,
                      label: 'Password',
                      prefix: Icons.password_outlined,
                      suffix: isObscure?Icons.visibility : Icons.visibility_off,
                      isObscure: isObscure,
                      onPressedSuffixIcon: ()
                      {
                        setState(() {

                          isObscure=!isObscure;
                        });
                      },

                      onSubmit: (value) {
                        print('Password Submit' + ' ' + value);
                      },
                      validate: (value) {
                      if (value!.isEmpty) {

                        return 'Password  is empty';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),

                  //Login Button
                  defaultButton(
                    text: 'Login',
                    background: Colors.blueGrey.withOpacity(0.4),
                    radius: 8,
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                        {
                          print(emailController.text);
                          print(passController.text);
                        }
                    },

                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Not Registered?'),
                      SizedBox(width: 5,),
                      TextButton(
                        onPressed: (){},
                        child: Text('Register Now'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
