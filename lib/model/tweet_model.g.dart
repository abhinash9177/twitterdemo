// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TweetmodelAdapter extends TypeAdapter<Tweetmodel> {
  @override
  final int typeId = 1;

  @override
  Tweetmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tweetmodel(
      name: fields[0] as String,
      id: fields[1] as int,
      tweet: fields[2] as String,
      image: fields[3] as String,
      comments: fields[4] as int,
      likes: fields[5] as int,
      reply: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Tweetmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.tweet)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.comments)
      ..writeByte(5)
      ..write(obj.likes)
      ..writeByte(6)
      ..write(obj.reply);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TweetmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
