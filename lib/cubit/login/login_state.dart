abstract class LoginState{}

class LoginInitialState extends LoginState{}

class LoginPasswordToggleState extends LoginState
{
  bool isPasswordVisible;
  LoginPasswordToggleState({required this.isPasswordVisible});
}

class LoginButtonState extends LoginState
{
  bool isValid = false;
  LoginButtonState({required this.isValid});
}