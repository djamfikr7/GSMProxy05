// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageThread _$MessageThreadFromJson(Map<String, dynamic> json) {
  return _MessageThread.fromJson(json);
}

/// @nodoc
mixin _$MessageThread {
  String get id => throw _privateConstructorUsedError;
  String get contactName => throw _privateConstructorUsedError;
  String get contactPhone => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  DateTime get lastMessageTime => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageThreadCopyWith<MessageThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageThreadCopyWith<$Res> {
  factory $MessageThreadCopyWith(
          MessageThread value, $Res Function(MessageThread) then) =
      _$MessageThreadCopyWithImpl<$Res, MessageThread>;
  @useResult
  $Res call(
      {String id,
      String contactName,
      String contactPhone,
      String lastMessage,
      DateTime lastMessageTime,
      int unreadCount,
      bool isArchived});
}

/// @nodoc
class _$MessageThreadCopyWithImpl<$Res, $Val extends MessageThread>
    implements $MessageThreadCopyWith<$Res> {
  _$MessageThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contactName = null,
    Object? contactPhone = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
    Object? isArchived = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contactName: null == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String,
      contactPhone: null == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageThreadImplCopyWith<$Res>
    implements $MessageThreadCopyWith<$Res> {
  factory _$$MessageThreadImplCopyWith(
          _$MessageThreadImpl value, $Res Function(_$MessageThreadImpl) then) =
      __$$MessageThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String contactName,
      String contactPhone,
      String lastMessage,
      DateTime lastMessageTime,
      int unreadCount,
      bool isArchived});
}

/// @nodoc
class __$$MessageThreadImplCopyWithImpl<$Res>
    extends _$MessageThreadCopyWithImpl<$Res, _$MessageThreadImpl>
    implements _$$MessageThreadImplCopyWith<$Res> {
  __$$MessageThreadImplCopyWithImpl(
      _$MessageThreadImpl _value, $Res Function(_$MessageThreadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contactName = null,
    Object? contactPhone = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
    Object? isArchived = null,
  }) {
    return _then(_$MessageThreadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contactName: null == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String,
      contactPhone: null == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageThreadImpl implements _MessageThread {
  const _$MessageThreadImpl(
      {required this.id,
      required this.contactName,
      required this.contactPhone,
      required this.lastMessage,
      required this.lastMessageTime,
      this.unreadCount = 0,
      this.isArchived = false});

  factory _$MessageThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageThreadImplFromJson(json);

  @override
  final String id;
  @override
  final String contactName;
  @override
  final String contactPhone;
  @override
  final String lastMessage;
  @override
  final DateTime lastMessageTime;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  @JsonKey()
  final bool isArchived;

  @override
  String toString() {
    return 'MessageThread(id: $id, contactName: $contactName, contactPhone: $contactPhone, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, contactName, contactPhone,
      lastMessage, lastMessageTime, unreadCount, isArchived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageThreadImplCopyWith<_$MessageThreadImpl> get copyWith =>
      __$$MessageThreadImplCopyWithImpl<_$MessageThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageThreadImplToJson(
      this,
    );
  }
}

abstract class _MessageThread implements MessageThread {
  const factory _MessageThread(
      {required final String id,
      required final String contactName,
      required final String contactPhone,
      required final String lastMessage,
      required final DateTime lastMessageTime,
      final int unreadCount,
      final bool isArchived}) = _$MessageThreadImpl;

  factory _MessageThread.fromJson(Map<String, dynamic> json) =
      _$MessageThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get contactName;
  @override
  String get contactPhone;
  @override
  String get lastMessage;
  @override
  DateTime get lastMessageTime;
  @override
  int get unreadCount;
  @override
  bool get isArchived;
  @override
  @JsonKey(ignore: true)
  _$$MessageThreadImplCopyWith<_$MessageThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
