import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataRepository<T, P> extends ChangeNotifier {
  DataRepository(T initialValue) : _subject = BehaviorSubject.seeded(initialValue);

  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;
  T get current => _subject.value;

  void emit(T value) {
    _subject.add(value);
    notifyListeners();
  }

  void emitError(Object error, [StackTrace? stackTrace]) {
    _subject.addError(error, stackTrace);
    notifyListeners();
  }

  Future<T> fetch(P params);

  @override
  void dispose() {
    _subject.close();
    super.dispose();
  }
}
