import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/models/app_user.dart';
import '../../data/sites_repo.dart';
import '../../services/firestore_service.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthVM extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _fireStoreService = locator<FirestoreService>();
  final _dataRepo = locator<DataRepo>();

  AuthVM() {
    _loginType = LoginType.signUp;
    _username = ValidationItem();
    _email = ValidationItem();
    _password = ValidationItem();
  }

  //Login type - Either Login or Sign up
  LoginType _loginType = LoginType.signUp;
  LoginType get loginType => _loginType;
  void toggleLoginType() {
    _hasAuthError = false;
    _buttonPressed = false;
    if (_loginType == LoginType.login) {
      _loginType = LoginType.signUp;
    } else {
      _loginType = LoginType.login;
    }
    notifyListeners();
  }

  bool get isSignUp => _loginType == LoginType.signUp;

  late ValidationItem _username;
  late ValidationItem _email;
  late ValidationItem _password;
  //SignUpData methods
  bool hasError(DataField dataField) {
    if (_loginType == LoginType.login) return false;
    switch (dataField) {
      case DataField.email:
        return _email.error;
      case DataField.password:
        return _password.error;
      case DataField.username:
        return _username.error;
      default:
        return false;
    }
  }

  void changeData(DataField dataField, String data) {
    _hasAuthError = false;
    switch (dataField) {
      case DataField.email:
        _email.data = data.trim();
        if (regExpEmail.hasMatch(data.trim())) {
          _email.error = false;
        } else {
          _email.error = true;
        }
        break;
      case DataField.password:
        _password.data = data.trim();
        if (data.trim().length >= 8) {
          _password.error = false;
        } else {
          _password.error = true;
        }
        break;
      case DataField.username:
        _username.data = data.trim();
        if (data.trim().length > 3) {
          _username.error = false;
        } else {
          _username.error = true;
        }
        break;
    }
    notifyListeners();
  }

  String getErrorMessage(DataField dataField, BuildContext context) {
    switch (dataField) {
      case DataField.email:
        if (_email.error) {
          return AppLocalizations.of(context)!.enterValidEmail;
        }
        break;
      case DataField.password:
        if (_password.error) {
          return AppLocalizations.of(context)!.passwordMustLong;
        }
        break;
      case DataField.username:
        if (_username.error) {
          return AppLocalizations.of(context)!.usernameMustBe;
        }
        break;
      default:
        return AppLocalizations.of(context)!.somethingWentWrong;
    }
    return AppLocalizations.of(context)!.somethingWentWrong;
  }

  int _getErrorNumber() {
    int answer = 0;
    if (_username.error) {
      answer++;
    }
    if (_password.error) {
      answer++;
    }
    if (_email.error) {
      answer++;
    }
    return answer;
  }

  //Login button pressed
  bool _buttonPressed = false;
  set buttonPressed(bool value) {
    _buttonPressed = value;
    notifyListeners();
  }

  bool get buttonPressed => _buttonPressed;
  //Data for animation
  final double _overallPosition = 180;
  double get overallPosition {
    if (_keyboardOpened) {
      return _overallPosition - 150;
    }
    return _overallPosition;
  }

  double get loginFieldPosition => overallPosition + 80;
  double get signUpFieldPosition => overallPosition + 40;

  bool _keyboardOpened = false;
  void changeVisibility(bool value) {
    _keyboardOpened = value;
    notifyListeners();
  }

  bool get keyboardOpened => _keyboardOpened;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Authentication - Register/Login
  bool _hasAuthError = false;
  String? _authErrorString;
  bool get hasAuthError => _hasAuthError;

  String authErrorString(BuildContext context) {
    switch (_authErrorString) {
      case 'email-already-in-use':
        return AppLocalizations.of(context)!.emailInUse;
      case 'invalid-email':
        return AppLocalizations.of(context)!.emailInvalid;
      case 'operation-not-allowed':
        return AppLocalizations.of(context)!.invalidOperation;
      case 'weak-password':
        return AppLocalizations.of(context)!.weakPassword;
      case 'user-not-found':
        return AppLocalizations.of(context)!.userNotFound;
      case 'empty-fields':
        return AppLocalizations.of(context)!.emptyFields;
      case 'wrong-password':
        return AppLocalizations.of(context)!.wrongPass;
      default:
        return AppLocalizations.of(context)!.somethingWentWrong;
    }
  }

  void _authError({String error = ''}) {
    _hasAuthError = true;
    log('In _authError: $error');
    _authErrorString = error;
    notifyListeners();
  }

  Future<bool> _signUpEmail() async {
    try {
      isLoading = true;

      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: _email.data,
        password: _password.data,
      );

      final newUser = _auth.currentUser;
      if (newUser != null) {
        final user = AppUser(
          uniqueID: authResult.user!.uid,
          email: authResult.user!.email!,
          username: _username.data,
          favouriteSites: [],
          votes: [],
        );

        await _fireStoreService.addUser(user);
        return true;
      }
    } on FirebaseAuthException catch (error) {
      _authError(error: error.code);
    } on Exception catch (error) {
      log('Something went wrong on login: $error');
    }
    return false;
  }

  Future<bool> _loginEmail() async {
    try {
      if (_email.data.isEmpty || _password.data.isEmpty) {
        _authError(error: 'empty-fields');
      } else {
        isLoading = true;
        await _auth.signInWithEmailAndPassword(
          email: _email.data,
          password: _password.data,
        );
        return true;
      }
    } on FirebaseAuthException catch (error) {
      _authError(error: error.code);
    }
    return false;
  }

  bool loginClicked = false;

  Future<void> signUp(BuildContext context) async {
    if (loginClicked) {
      return;
    }
    buttonPressed = true;
    _hasAuthError = false;
    loginClicked = true;
    bool success = false;
    if (_loginType == LoginType.signUp) {
      if (_getErrorNumber() == 0) {
        success = await _signUpEmail();
      } else {
        log('There are register errors');
      }
    } else if (_loginType == LoginType.login) {
      success = await _loginEmail();
    }
    if (success && _auth.currentUser != null) {
      await _dataRepo.init();
      await Navigator.of(context).pushReplacementNamed(
        Routes.primary,
      );
    }
    isLoading = false;
    loginClicked = false;
  }
}

enum LoginType { login, signUp }
enum DataField { email, password, username }

class ValidationItem {
  String data = '';
  bool error = true;
}
