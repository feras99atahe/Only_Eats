import 'package:equatable/equatable.dart';
import '../../auth/domain/entities/user.dart';

class Video extends Equatable {
  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final String description;
  final User uploader;
  final DateTime uploadDate;
  final int likesCount;
  final int commentsCount;
  final List<String> tags;
  final bool isLiked;

  const Video({
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
    required this.description,
    required this.uploader,
    required this.uploadDate,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.tags = const [],
    this.isLiked = false,
  });

  Video copyWith({
    String? id,
    String? videoUrl,
    String? thumbnailUrl,
    String? title,
    String? description,
    User? uploader,
    DateTime? uploadDate,
    int? likesCount,
    int? commentsCount,
    List<String>? tags,
    bool? isLiked,
  }) {
    return Video(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      uploader: uploader ?? this.uploader,
      uploadDate: uploadDate ?? this.uploadDate,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      tags: tags ?? this.tags,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object> get props => [
        id,
        videoUrl,
        thumbnailUrl,
        title,
        description,
        uploader,
        uploadDate,
        likesCount,
        commentsCount,
        tags,
        isLiked,
      ];
}

