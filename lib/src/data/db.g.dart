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
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
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

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String label;
  final DateTime date;
  final int color;
  Tag({this.id, @required this.label, this.date, @required this.color});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      label:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}label']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      date: serializer.fromJson<DateTime>(json['date']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'date': serializer.toJson<DateTime>(date),
      'color': serializer.toJson<int>(color),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  Tag copyWith({int id, String label, DateTime date, int color}) => Tag(
        id: id ?? this.id,
        label: label ?? this.label,
        date: date ?? this.date,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('date: $date, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(label.hashCode, $mrjc(date.hashCode, color.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.label == this.label &&
          other.date == this.date &&
          other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> label;
  final Value<DateTime> date;
  final Value<int> color;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.date = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String label,
    this.date = const Value.absent(),
    @required int color,
  })  : label = Value(label),
        color = Value(color);
  TagsCompanion copyWith(
      {Value<int> id,
      Value<String> label,
      Value<DateTime> date,
      Value<int> color}) {
    return TagsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      date: date ?? this.date,
      color: color ?? this.color,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _labelMeta = const VerificationMeta('label');
  GeneratedTextColumn _label;
  @override
  GeneratedTextColumn get label => _label ??= _constructLabel();
  GeneratedTextColumn _constructLabel() {
    return GeneratedTextColumn('label', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, label, date, color];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.label.present) {
      context.handle(
          _labelMeta, label.isAcceptableValue(d.label.value, _labelMeta));
    } else if (label.isRequired && isInserting) {
      context.missing(_labelMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.label.present) {
      map['label'] = Variable<String, StringType>(d.label.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.color.present) {
      map['color'] = Variable<int, IntType>(d.color.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class Pomodoro extends DataClass implements Insertable<Pomodoro> {
  final int id;
  final DateTime date;
  final int goalId;
  Pomodoro({this.id, this.date, @required this.goalId});
  factory Pomodoro.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Pomodoro(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      goalId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}goal_id']),
    );
  }
  factory Pomodoro.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Pomodoro(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      goalId: serializer.fromJson<int>(json['goalId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'goalId': serializer.toJson<int>(goalId),
    };
  }

  @override
  PomodorosCompanion createCompanion(bool nullToAbsent) {
    return PomodorosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
    );
  }

  Pomodoro copyWith({int id, DateTime date, int goalId}) => Pomodoro(
        id: id ?? this.id,
        date: date ?? this.date,
        goalId: goalId ?? this.goalId,
      );
  @override
  String toString() {
    return (StringBuffer('Pomodoro(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('goalId: $goalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(date.hashCode, goalId.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Pomodoro &&
          other.id == this.id &&
          other.date == this.date &&
          other.goalId == this.goalId);
}

class PomodorosCompanion extends UpdateCompanion<Pomodoro> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> goalId;
  const PomodorosCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.goalId = const Value.absent(),
  });
  PomodorosCompanion.insert({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    @required int goalId,
  }) : goalId = Value(goalId);
  PomodorosCompanion copyWith(
      {Value<int> id, Value<DateTime> date, Value<int> goalId}) {
    return PomodorosCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      goalId: goalId ?? this.goalId,
    );
  }
}

class $PomodorosTable extends Pomodoros
    with TableInfo<$PomodorosTable, Pomodoro> {
  final GeneratedDatabase _db;
  final String _alias;
  $PomodorosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  GeneratedIntColumn _goalId;
  @override
  GeneratedIntColumn get goalId => _goalId ??= _constructGoalId();
  GeneratedIntColumn _constructGoalId() {
    return GeneratedIntColumn('goal_id', $tableName, false,
        $customConstraints: 'REFERENCES goals(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, date, goalId];
  @override
  $PomodorosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'pomodoros';
  @override
  final String actualTableName = 'pomodoros';
  @override
  VerificationContext validateIntegrity(PomodorosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.goalId.present) {
      context.handle(
          _goalIdMeta, goalId.isAcceptableValue(d.goalId.value, _goalIdMeta));
    } else if (goalId.isRequired && isInserting) {
      context.missing(_goalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, goalId};
  @override
  Pomodoro map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Pomodoro.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PomodorosCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.goalId.present) {
      map['goal_id'] = Variable<int, IntType>(d.goalId.value);
    }
    return map;
  }

  @override
  $PomodorosTable createAlias(String alias) {
    return $PomodorosTable(_db, alias);
  }
}

class TagsGoal extends DataClass implements Insertable<TagsGoal> {
  final int goalId;
  final int tagId;
  TagsGoal({@required this.goalId, @required this.tagId});
  factory TagsGoal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return TagsGoal(
      goalId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}goal_id']),
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
    );
  }
  factory TagsGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TagsGoal(
      goalId: serializer.fromJson<int>(json['goalId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'goalId': serializer.toJson<int>(goalId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  @override
  TagsGoalsCompanion createCompanion(bool nullToAbsent) {
    return TagsGoalsCompanion(
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
    );
  }

  TagsGoal copyWith({int goalId, int tagId}) => TagsGoal(
        goalId: goalId ?? this.goalId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('TagsGoal(')
          ..write('goalId: $goalId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(goalId.hashCode, tagId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TagsGoal &&
          other.goalId == this.goalId &&
          other.tagId == this.tagId);
}

class TagsGoalsCompanion extends UpdateCompanion<TagsGoal> {
  final Value<int> goalId;
  final Value<int> tagId;
  const TagsGoalsCompanion({
    this.goalId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  TagsGoalsCompanion.insert({
    @required int goalId,
    @required int tagId,
  })  : goalId = Value(goalId),
        tagId = Value(tagId);
  TagsGoalsCompanion copyWith({Value<int> goalId, Value<int> tagId}) {
    return TagsGoalsCompanion(
      goalId: goalId ?? this.goalId,
      tagId: tagId ?? this.tagId,
    );
  }
}

class $TagsGoalsTable extends TagsGoals
    with TableInfo<$TagsGoalsTable, TagsGoal> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsGoalsTable(this._db, [this._alias]);
  final VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  GeneratedIntColumn _goalId;
  @override
  GeneratedIntColumn get goalId => _goalId ??= _constructGoalId();
  GeneratedIntColumn _constructGoalId() {
    return GeneratedIntColumn('goal_id', $tableName, false,
        $customConstraints: 'REFERENCES goals(id)');
  }

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedIntColumn _tagId;
  @override
  GeneratedIntColumn get tagId => _tagId ??= _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn('tag_id', $tableName, false,
        $customConstraints: 'REFERENCES tags(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [goalId, tagId];
  @override
  $TagsGoalsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags_goals';
  @override
  final String actualTableName = 'tags_goals';
  @override
  VerificationContext validateIntegrity(TagsGoalsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.goalId.present) {
      context.handle(
          _goalIdMeta, goalId.isAcceptableValue(d.goalId.value, _goalIdMeta));
    } else if (goalId.isRequired && isInserting) {
      context.missing(_goalIdMeta);
    }
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (tagId.isRequired && isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {goalId, tagId};
  @override
  TagsGoal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TagsGoal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsGoalsCompanion d) {
    final map = <String, Variable>{};
    if (d.goalId.present) {
      map['goal_id'] = Variable<int, IntType>(d.goalId.value);
    }
    if (d.tagId.present) {
      map['tag_id'] = Variable<int, IntType>(d.tagId.value);
    }
    return map;
  }

  @override
  $TagsGoalsTable createAlias(String alias) {
    return $TagsGoalsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $GoalsTable _goals;
  $GoalsTable get goals => _goals ??= $GoalsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $PomodorosTable _pomodoros;
  $PomodorosTable get pomodoros => _pomodoros ??= $PomodorosTable(this);
  $TagsGoalsTable _tagsGoals;
  $TagsGoalsTable get tagsGoals => _tagsGoals ??= $TagsGoalsTable(this);
  GoalsDao _goalsDao;
  GoalsDao get goalsDao => _goalsDao ??= GoalsDao(this as AppDatabase);
  TagsDao _tagsDao;
  TagsDao get tagsDao => _tagsDao ??= TagsDao(this as AppDatabase);
  PomodorosDao _pomodorosDao;
  PomodorosDao get pomodorosDao =>
      _pomodorosDao ??= PomodorosDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [goals, tags, pomodoros, tagsGoals];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GoalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTable get goals => db.goals;
  $TagsTable get tags => db.tags;
  $TagsGoalsTable get tagsGoals => db.tagsGoals;
  $PomodorosTable get pomodoros => db.pomodoros;
}
mixin _$TagsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => db.tags;
  $TagsGoalsTable get tagsGoals => db.tagsGoals;
}
mixin _$PomodorosDaoMixin on DatabaseAccessor<AppDatabase> {
  $PomodorosTable get pomodoros => db.pomodoros;
}
