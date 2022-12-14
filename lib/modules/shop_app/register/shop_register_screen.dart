import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/shop_layout.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/states.dart';
import 'package:newflutter_2022/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:newflutter_2022/modules/shop_app/register/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/register/cubit/states.dart';
import 'package:newflutter_2022/modules/shop_app/register/shop_register_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var nameController= TextEditingController();
  var phoneController= TextEditingController();
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider( create:(context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(

        listener: (context,state) async
        {
          if(state is ShopRegisterSuccessState)  //The Right way of handling the api, here if login is successful and there is such record then it will print message and token, else message only since there is no token.
              {
            if(state.loginModel.status == true)
            {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              await DefaultToast(
                  msg: '${state.loginModel.message}',
                  state: ToastStates.SUCCESS,
              );

              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)  //to save the token, so I have logged in and moved to home page.
              {
                token=state.loginModel.data!.token!;  //To renew the token if I logged out and went in again.
                navigateAndFinish(context, const ShopLayout());
              });
            }
            else
            {
              print(state.loginModel.message);

              await DefaultToast(
                  msg: '${state.loginModel.message}',
                  state: ToastStates.ERROR,
              );
            }

          }
        },

        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),

                        const SizedBox(height: 5,),

                        Text(
                          'Register NOW to catch up with all the new products!',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith
                            (color: Colors.grey),
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                            controller: nameController,
                            keyboard: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Name is Empty';
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                            controller: emailController,
                            keyboard: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Email Address is Empty';
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                            controller: passwordController,
                            keyboard: TextInputType.visiblePassword,
                            label: 'Password',
                            isObscure: ShopRegisterCubit.get(context).isPasswordShown,
                            prefix: Icons.lock_outlined,
                            suffix:  ShopRegisterCubit.get(context).suffix,
                            onPressedSuffixIcon: ()
                            {
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Password is Empty';
                              }
                              return null;
                            },

                            onSubmit: (value)
                            {}
                        ),

                        const SizedBox(height: 30,),


                        defaultFormField(
                            controller: phoneController,
                            keyboard: TextInputType.phone,
                            label: 'Phone',
                            prefix: Icons.phone_android,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Phone is Empty';
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          fallback: (context)=> const Center(child: CircularProgressIndicator()),
                          builder: (context)=> defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Register'),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
