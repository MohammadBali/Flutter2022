import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/shop_layout.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/states.dart';
import 'package:newflutter_2022/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:newflutter_2022/modules/shop_app/register/shop_register_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

   var EmailController= TextEditingController();
   var PasswordController= TextEditingController();
   var FormKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state) async
        {
          if(state is ShopLoginSuccessState)  //The Right way of handling the api, here if login is successful and there is such record then it will print message and token, else message only since there is no token.
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
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),

                        const SizedBox(height: 5,),

                        Text(
                          'Catch up with all the new products!',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith
                            (color: Colors.grey),
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                            controller: EmailController,
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
                            controller: PasswordController,
                            keyboard: TextInputType.visiblePassword,
                            label: 'Password',
                            isObscure: ShopLoginCubit.get(context).isPasswordShown,
                            prefix: Icons.lock_outlined,
                            suffix:  ShopLoginCubit.get(context).suffix,
                            onPressedSuffixIcon: ()
                            {
                              ShopLoginCubit.get(context).changePasswordVisibility();
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
                            {
                              if(FormKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                );
                              }
                            }
                        ),

                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context)=> const Center(child: CircularProgressIndicator()),
                          builder: (context)=> defaultButton(
                              function: ()
                              {
                                if(FormKey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                    );
                                  }
                              },
                              text: 'login'),
                        ),

                        const SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text('Don\'t Have an Email yet?'),
                            const SizedBox(width: 5,),
                            defaultTextButton(
                              onPressed: ()
                              {
                                navigateAndFinish(context, ShopRegisterScreen());
                              },
                              text: 'sign up',
                            )
                          ],
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
