import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/cubit/splash/splash_cubit.dart';

import '../cubit/splash/splash_state.dart';
import '../utils/app_nav_path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.loginPage) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppNavPath.loginPage, (route) => false);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/evital.jpeg",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(strokeWidth: 3.0,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
