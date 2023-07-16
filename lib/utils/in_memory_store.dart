import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final previousPriceUSDProvider =
    StateProvider<InMemoryStore<double>>((_) => InMemoryStore<double>(0.0));

final previousPriceJPYProvider =
    StateProvider<InMemoryStore<double>>((_) => InMemoryStore<double>(0.0));

class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  final BehaviorSubject<T?> _subject;

  Stream<T?> get stream => _subject.stream;

  T? get value => _subject.value;

  set value(T? value) {
    _subject.sink.add(value);
  }

  void close() => _subject.close();
}
