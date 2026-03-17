import 'package:flutter/foundation.dart';

class BaseCubit<S> extends ChangeNotifier {
  BaseCubit(this._state);

  S _state;

  S get state => _state;

  void emit(S state) {
    _state = state;
    notifyListeners();
  }
}
