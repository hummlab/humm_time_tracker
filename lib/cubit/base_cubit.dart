import 'package:flutter/foundation.dart';

class BaseCubit<S> extends ChangeNotifier {
  BaseCubit(this._state);

  S _state;
  bool _isDisposed = false;

  S get state => _state;
  bool get isDisposed => _isDisposed;

  void emit(S state) {
    if (_isDisposed) return;
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
