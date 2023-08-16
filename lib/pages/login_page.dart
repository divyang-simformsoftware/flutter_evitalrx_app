import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/utils/app_strings.dart';

import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../utils/app_nav_path.dart';
import '../widget/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        toolbarHeight: theme.appBarTheme.toolbarHeight,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 400,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const CircleAvatar(
                        maxRadius: 40,
                        backgroundImage:
                            AssetImage(AppStrings.eVitalRXLogoPath),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustomTextField(
                            enabled: state is LoginButtonState
                                ? state.isValid
                                    ? false
                                    : true
                                : true,
                            labelText: "Mobile no.",
                            textInputType: TextInputType.number,
                            textLength: 10,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.phone),
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustomTextField(
                            enabled: state is LoginButtonState
                                ? state.isValid
                                    ? false
                                    : true
                                : true,
                            labelText: "Password",
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            isVisiblePassword: state is LoginPasswordToggleState
                                ? state.isPasswordVisible
                                : true,
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: cubit.togglePassword,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Builder(builder: (context) {
                                return Icon(
                                  state is LoginPasswordToggleState
                                      ? state.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off
                                      : Icons.visibility,
                                );
                              }),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginButtonState) {
                            if (state.isValid) {
                              Future.delayed(
                                const Duration(seconds: 3),
                                () {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppNavPath.dashboardPage);
                                },
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return state is LoginButtonState
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : MaterialButton(
                                  color: theme.primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.checkValidLogin(isValid: true);
                                    }
                                  },
                                  child: const Text("Login in eVitalRX"),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
