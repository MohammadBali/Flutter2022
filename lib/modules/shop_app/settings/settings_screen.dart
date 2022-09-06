import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/states.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {

  var nameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context,state)
      {},

      builder: (context,state)
      {
        var model=ShopCubit.get(context).userModel;

        if(model!= null)
          {
            final data = model.data;
            if(data != null)
              {
                nameController.text= data.name!;

                emailController.text=data.email! ;

                phoneController.text=data.phone! ;
              }
          }

        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    [
                      if(state is ShopLoadingUserUpdateState)
                      const LinearProgressIndicator(),
                      const SizedBox(height: 20,),
                      defaultFormField(
                        controller: nameController,
                        keyboard: TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person,
                        validate:(String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30,),

                      defaultFormField(
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email,
                        validate:(String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30,),

                      defaultFormField(
                        controller: phoneController,
                        keyboard: TextInputType.phone,
                        label: 'Phone Number',
                        prefix: Icons.phone_android,
                        validate:(String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30,),

                      defaultButton(
                          function: ()
                          {
                            if(formKey.currentState?.validate()==true)  //Make sure that there is data.
                              {
                                ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                          },
                          text: 'update'
                      ),

                      const SizedBox(height: 20,),

                      defaultButton(
                          function: ()
                          {
                            signOut(context);
                          },
                          text: 'Log Out'
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
