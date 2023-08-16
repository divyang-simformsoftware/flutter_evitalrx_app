import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  bool _isPassVisible = false;
  LoginCubit() : super(LoginInitialState());

  void togglePassword() {
  
    emit(LoginPasswordToggleState(isPasswordVisible: _isPassVisible = !_isPassVisible));
  }

  void checkValidLogin({required bool isValid}) {
    emit(LoginButtonState(isValid: isValid));
  }
}
