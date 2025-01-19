// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastActive =>
      throw _privateConstructorUsedError; // Personal Information
  String? get gender => throw _privateConstructorUsedError;
  String? get horoscope => throw _privateConstructorUsedError;
  String? get occupation => throw _privateConstructorUsedError;
  String? get relationshipStatus => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  bool get hasCompletedPersonalization => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {String userId,
      String email,
      String? displayName,
      String? photoUrl,
      bool notificationsEnabled,
      Map<String, dynamic> preferences,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastActive,
      String? gender,
      String? horoscope,
      String? occupation,
      String? relationshipStatus,
      DateTime? birthDate,
      List<String> interests,
      bool hasCompletedPersonalization});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? notificationsEnabled = null,
    Object? preferences = null,
    Object? createdAt = null,
    Object? lastActive = null,
    Object? gender = freezed,
    Object? horoscope = freezed,
    Object? occupation = freezed,
    Object? relationshipStatus = freezed,
    Object? birthDate = freezed,
    Object? interests = null,
    Object? hasCompletedPersonalization = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      horoscope: freezed == horoscope
          ? _value.horoscope
          : horoscope // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: freezed == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: freezed == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasCompletedPersonalization: null == hasCompletedPersonalization
          ? _value.hasCompletedPersonalization
          : hasCompletedPersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String email,
      String? displayName,
      String? photoUrl,
      bool notificationsEnabled,
      Map<String, dynamic> preferences,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastActive,
      String? gender,
      String? horoscope,
      String? occupation,
      String? relationshipStatus,
      DateTime? birthDate,
      List<String> interests,
      bool hasCompletedPersonalization});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? notificationsEnabled = null,
    Object? preferences = null,
    Object? createdAt = null,
    Object? lastActive = null,
    Object? gender = freezed,
    Object? horoscope = freezed,
    Object? occupation = freezed,
    Object? relationshipStatus = freezed,
    Object? birthDate = freezed,
    Object? interests = null,
    Object? hasCompletedPersonalization = null,
  }) {
    return _then(_$ProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      horoscope: freezed == horoscope
          ? _value.horoscope
          : horoscope // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: freezed == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: freezed == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasCompletedPersonalization: null == hasCompletedPersonalization
          ? _value.hasCompletedPersonalization
          : hasCompletedPersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {required this.userId,
      required this.email,
      this.displayName,
      this.photoUrl,
      this.notificationsEnabled = false,
      final Map<String, dynamic> preferences = const {},
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.lastActive,
      this.gender,
      this.horoscope,
      this.occupation,
      this.relationshipStatus,
      this.birthDate,
      final List<String> interests = const [],
      this.hasCompletedPersonalization = false})
      : _preferences = preferences,
        _interests = interests;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String userId;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime lastActive;
// Personal Information
  @override
  final String? gender;
  @override
  final String? horoscope;
  @override
  final String? occupation;
  @override
  final String? relationshipStatus;
  @override
  final DateTime? birthDate;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  @JsonKey()
  final bool hasCompletedPersonalization;

  @override
  String toString() {
    return 'Profile(userId: $userId, email: $email, displayName: $displayName, photoUrl: $photoUrl, notificationsEnabled: $notificationsEnabled, preferences: $preferences, createdAt: $createdAt, lastActive: $lastActive, gender: $gender, horoscope: $horoscope, occupation: $occupation, relationshipStatus: $relationshipStatus, birthDate: $birthDate, interests: $interests, hasCompletedPersonalization: $hasCompletedPersonalization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.horoscope, horoscope) ||
                other.horoscope == horoscope) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.relationshipStatus, relationshipStatus) ||
                other.relationshipStatus == relationshipStatus) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.hasCompletedPersonalization,
                    hasCompletedPersonalization) ||
                other.hasCompletedPersonalization ==
                    hasCompletedPersonalization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      email,
      displayName,
      photoUrl,
      notificationsEnabled,
      const DeepCollectionEquality().hash(_preferences),
      createdAt,
      lastActive,
      gender,
      horoscope,
      occupation,
      relationshipStatus,
      birthDate,
      const DeepCollectionEquality().hash(_interests),
      hasCompletedPersonalization);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {required final String userId,
      required final String email,
      final String? displayName,
      final String? photoUrl,
      final bool notificationsEnabled,
      final Map<String, dynamic> preferences,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() required final DateTime lastActive,
      final String? gender,
      final String? horoscope,
      final String? occupation,
      final String? relationshipStatus,
      final DateTime? birthDate,
      final List<String> interests,
      final bool hasCompletedPersonalization}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String get userId;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  bool get notificationsEnabled;
  @override
  Map<String, dynamic> get preferences;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get lastActive; // Personal Information
  @override
  String? get gender;
  @override
  String? get horoscope;
  @override
  String? get occupation;
  @override
  String? get relationshipStatus;
  @override
  DateTime? get birthDate;
  @override
  List<String> get interests;
  @override
  bool get hasCompletedPersonalization;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
