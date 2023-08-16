import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/cubit/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.splashPage){
    _navigatingPage();
  }

  void _navigatingPage() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        emit(SplashState.loginPage);
      },
    );
  }
}
