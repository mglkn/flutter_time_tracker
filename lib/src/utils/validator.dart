import 'package:meta/meta.dart';

import '../data/db_repository.dart';
import 'app_localization.dart';

abstract class Validator {
  Future<String> validateTagLabel(String label, [String editingTag]);

  factory Validator.instance({
    DbDataRepository db,
    AppLocalizations locale,
  }) =>
      _Validator.instance(db: db, locale: locale);
}

class _Validator implements Validator {
  DbDataRepository _db;
  AppLocalizations _locale;

  _Validator._internal({
    @required DbDataRepository db,
    @required AppLocalizations locale,
  })  : _db = db,
        _locale = locale,
        assert(db != null),
        assert(locale != null);

  static _Validator _instance;

  factory _Validator.instance({
    DbDataRepository db,
    AppLocalizations locale,
  }) {
    if (_instance != null) {
      return _instance;
    }

    _instance = _Validator._internal(db: db, locale: locale);
    return _instance;
  }

  static RegExp _isValidTag = RegExp(r"[^A-Za-zа-яА-Яё0-9\s]");
  static int _minTagLabelLong = 1;
  static int _maxTagLabelLong = 30;

  Future<String> validateTagLabel(String label, [String editingTag]) async {
    if (label.length < _minTagLabelLong || label.length > _maxTagLabelLong) {
      return _locale.translate("tagLabelLendthError");
    }

    if (_isValidTag.hasMatch(label)) {
      return _locale.translate("tagLabelNotMatchError");
    }

    var existedTag;
    if (label.length == 0 || label == editingTag) {
      existedTag = null;
    } else {
      existedTag = await _db.getTagByLabel(label);
    }

    if (existedTag != null) {
      return _locale.translate("tagLabelUniqueError");
    }

    return null;
  }
}
