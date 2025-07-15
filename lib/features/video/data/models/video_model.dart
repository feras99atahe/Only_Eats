import '../../domain/entities/video.dart';
import '../../../auth/data/models/user_model.dart';

class VideoModel extends Video {
  const VideoModel({
    required String id,
    required String videoUrl,
    required String thumbnailUrl,
    required String title,
    required String description,
    required UserModel uploader,
    required DateTime uploadDate,
    int likesCount = 0,
    int commentsCount = 0,
    List<String> tags = const [],
    bool isLiked = false,
  }) : super(
          id: id,
          videoUrl: videoUrl,
          thumbnailUrl: thumbnailUrl,
          title: title,
          description: description,
          uploader: uploader,
          uploadDate: uploadDate,
          likesCount: likesCount,
          commentsCount: commentsCount,
          tags: tags,
          isLiked: isLiked,
        );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      uploader: UserModel.fromJson(json['uploader'] as Map<String, dynamic>),
      uploadDate: DateTime.parse(json['uploadDate'] as String),
      likesCount: json['likesCount'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
      tags: List<String>.from(json['tags'] as List? ?? []),
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'title': title,
      'description': description,
      'uploader': (uploader as UserModel).toJson(),
      'uploadDate': uploadDate.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'tags': tags,
      'isLiked': isLiked,
    };
  }
}

