// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DreamEntry _$DreamEntryFromJson(Map<String, dynamic> json) {
  return _DreamEntry.fromJson(json);
}

/// @nodoc
mixin _$DreamEntry {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get interpretation => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int get moodRating => throw _privateConstructorUsedError;

  /// Serializes this DreamEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DreamEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DreamEntryCopyWith<DreamEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DreamEntryCopyWith<$Res> {
  factory $DreamEntryCopyWith(
          DreamEntry value, $Res Function(DreamEntry) then) =
      _$DreamEntryCopyWithImpl<$Res, DreamEntry>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String content,
      String interpretation,
      DateTime createdAt,
      bool isFavourite,
      List<String> tags,
      int moodRating});
}

/// @nodoc
class _$DreamEntryCopyWithImpl<$Res, $Val extends DreamEntry>
    implements $DreamEntryCopyWith<$Res> {
  _$DreamEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DreamEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? interpretation = null,
    Object? createdAt = null,
    Object? isFavourite = null,
    Object? tags = null,
    Object? moodRating = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      interpretation: null == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moodRating: null == moodRating
          ? _value.moodRating
          : moodRating // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DreamEntryImplCopyWith<$Res>
    implements $DreamEntryCopyWith<$Res> {
  factory _$$DreamEntryImplCopyWith(
          _$DreamEntryImpl value, $Res Function(_$DreamEntryImpl) then) =
      __$$DreamEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String content,
      String interpretation,
      DateTime createdAt,
      bool isFavourite,
      List<String> tags,
      int moodRating});
}

/// @nodoc
class __$$DreamEntryImplCopyWithImpl<$Res>
    extends _$DreamEntryCopyWithImpl<$Res, _$DreamEntryImpl>
    implements _$$DreamEntryImplCopyWith<$Res> {
  __$$DreamEntryImplCopyWithImpl(
      _$DreamEntryImpl _value, $Res Function(_$DreamEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DreamEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? interpretation = null,
    Object? createdAt = null,
    Object? isFavourite = null,
    Object? tags = null,
    Object? moodRating = null,
  }) {
    return _then(_$DreamEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      interpretation: null == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      moodRating: null == moodRating
          ? _value.moodRating
          : moodRating // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DreamEntryImpl implements _DreamEntry {
  const _$DreamEntryImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.interpretation,
      required this.createdAt,
      this.isFavourite = false,
      final List<String> tags = const [],
      this.moodRating = 0})
      : _tags = tags;

  factory _$DreamEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DreamEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String content;
  @override
  final String interpretation;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isFavourite;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final int moodRating;

  @override
  String toString() {
    return 'DreamEntry(id: $id, userId: $userId, title: $title, content: $content, interpretation: $interpretation, createdAt: $createdAt, isFavourite: $isFavourite, tags: $tags, moodRating: $moodRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DreamEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.interpretation, interpretation) ||
                other.interpretation == interpretation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.moodRating, moodRating) ||
                other.moodRating == moodRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      content,
      interpretation,
      createdAt,
      isFavourite,
      const DeepCollectionEquality().hash(_tags),
      moodRating);

  /// Create a copy of DreamEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DreamEntryImplCopyWith<_$DreamEntryImpl> get copyWith =>
      __$$DreamEntryImplCopyWithImpl<_$DreamEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DreamEntryImplToJson(
      this,
    );
  }
}

abstract class _DreamEntry implements DreamEntry {
  const factory _DreamEntry(
      {required final String id,
      required final String userId,
      required final String title,
      required final String content,
      required final String interpretation,
      required final DateTime createdAt,
      final bool isFavourite,
      final List<String> tags,
      final int moodRating}) = _$DreamEntryImpl;

  factory _DreamEntry.fromJson(Map<String, dynamic> json) =
      _$DreamEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get content;
  @override
  String get interpretation;
  @override
  DateTime get createdAt;
  @override
  bool get isFavourite;
  @override
  List<String> get tags;
  @override
  int get moodRating;

  /// Create a copy of DreamEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DreamEntryImplCopyWith<_$DreamEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
