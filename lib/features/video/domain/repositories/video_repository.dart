import '../entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> getVideoFeed({int page = 0, int limit = 10});
  Future<Video> uploadVideo({
    required String filePath,
    required String title,
    required String description,
    required List<String> tags,
  });
  Future<void> likeVideo(String videoId);
  Future<void> unlikeVideo(String videoId);
  Future<Video> getVideoById(String videoId);
}

