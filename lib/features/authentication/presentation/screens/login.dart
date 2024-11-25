import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:todo/common/resource_images.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_input_widget.dart';
import 'package:todo/core/widgets/custom_loading_widget.dart';
import 'package:todo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:todo/features/authentication/utils/keyboard_actions_configs.dart';
import 'package:todo/features/authentication/utils/validation_methods.dart';

class LoginScreen extends StatelessWidget {
  final AuthBloc authBloc = AuthBloc();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();
  final FocusNode pwdNode = FocusNode();

  LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessful) {
            final successMessage = "Successful login";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(successMessage),
            ));
            context.go('/toDo');
          } else if (state is AuthError) {
            String? errorMessage;
            switch (state.code) {
              case 'wrong-password':
                errorMessage = "Wrong password provided for that user.";
                break;
              case 'user-not-found':
                errorMessage = "No user found for that email.";
                break;
              case 'INVALID_LOGIN_CREDENTIALS':
                errorMessage = "No user found for that email.";
                break;
              default:
                errorMessage = state.message;
                break;
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: $errorMessage'),
            ));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildBody(context),
              if (state is Loading) const CustomLoadingWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          Column(
            children: [
              Center(child: SvgPicture.asset(loginImage, height: 70)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          _buildForm(),
          CustomButton(
            text: "Log in",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                authBloc.add(SignIn());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: KeyboardActions(
        disableScroll: true,
        config: loginConfig(emailNode, pwdNode),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmailField(),
              SizedBox(
                height: 20,
              ),
              _buildPasswordField()
            ],
          ),
        ),
      ),
    );
  }

  CustomInput _buildEmailField() {
    return CustomInput(
      initialValue: "kevin.alexander@pinzon.com",
      hintText: "Enter your email",
      inputFieldTitle: "Email",
      focusNode: emailNode,
      validator: (value) => ValidationMethods.validateMail(value),
    );
  }

  CustomInput _buildPasswordField() {
    return CustomInput(
      initialValue: "Test123@",
      hintText: "Enter your password",
      inputFieldTitle: "Password",
      validator: (value) => ValidationMethods.validatePassword(value),
      focusNode: pwdNode,
    );
  }
}
