import 'dart:async';

class DbDataRepository {
  factory DbDataRepository.db() => _DbDataRepository();
}

class _DbDataRepository implements DbDataRepository {
  _DbDataRepository._internal();
  static final _DbDataRepository _instance = _DbDataRepository._internal();
  factory _DbDataRepository() => _instance;
}
