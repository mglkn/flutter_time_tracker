// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final bool isDone;
  final DateTime date;
  final String label;
  Goal({this.id, this.isDone, this.date, @required this.label});
  factory Goal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Goal(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      label:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}label']),
    );
  }
  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      date: serializer.fromJson<DateTime>(json['date']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isDone': serializer.toJson<bool>(isDone),
      'date': serializer.toJson<DateTime>(date),
      'label': serializer.toJson<String>(label),
    };
  }

  @override
  GoalsCompanion createCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
    );
  }

  Goal copyWith({int id, bool isDone, DateTime date, String label}) => Goal(
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        date: date ?? this.date,
        label: label ?? this.label,
      );
  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('isDone: $isDone, ')
          ..write('date: $date, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(isDone.hashCode, $mrjc(date.hashCode, label.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.isDone == this.isDone &&
          other.date == this.date &&
          other.label == this.label);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<bool> isDone;
  final Value<DateTime> date;
  final Value<String> label;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.isDone = const Value.absent(),
    this.date = const Value.absent(),
    this.label = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    this.isDone = const Value.absent(),
    this.date = const Value.absent(),
    @required String label,
  }) : label = Value(label);
  GoalsCompanion copyWith(
      {Value<int> id,
      Value<bool> isDone,
      Value<DateTime> date,
      Value<String> label}) {
    return GoalsCompanion(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      label: label ?? this.label,
    );
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  final GeneratedDatabase _db;
  final String _alias;
  $GoalsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, true,
        defaultValue: Constant(false));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn('date', $tableName, true,
        defaultValue: Constant(DateTime.now()));
  }

  final VerificationMeta _labelMeta = const VerificationMeta('label');
  GeneratedTextColumn _label;
  @override
  GeneratedTextColumn get label => _label ??= _constructLabel();
  GeneratedTextColumn _constructLabel() {
    return GeneratedTextColumn('label', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, isDone, date, label];
  @override
  $GoalsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'goals';
  @override
  final String actualTableName = 'goals';
  @override
  VerificationContext validateIntegrity(GoalsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.isDone.present) {
      context.handle(
          _isDoneMeta, isDone.isAcceptableValue(d.isDone.value, _isDoneMeta));
    } else if (isDone.isRequired && isInserting) {
      context.missing(_isDoneMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.label.present) {
      context.handle(
          _labelMeta, label.isAcceptableValue(d.label.value, _labelMeta));
    } else if (label.isRequired && isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Goal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(GoalsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.isDone.present) {
      map['is_done'] = Variable<bool, BoolType>(d.isDone.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.label.present) {
      map['label'] = Variable<String, StringType>(d.label.value);
    }
    return map;
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $GoalsTable _goals;
  $GoalsTable get goals => _goals ??= $GoalsTable(this);
  GoalsDao _goalsDao;
  GoalsDao get goalsDao => _goalsDao ??= GoalsDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [goals];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GoalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => db.goals;
}
