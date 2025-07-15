import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/video.dart';

// Events
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideoFeed extends VideoEvent {
  final bool refresh;
  
  const LoadVideoFeed({this.refresh = false});
  
  @override
  List<Object> get props => [refresh];
}

class UploadNewVideo extends VideoEvent {
  final String filePath;
  final String title;
  final String description;
  final List<String> tags;

  const UploadNewVideo({
    required this.filePath,
    required this.title,
    required this.description,
    required this.tags,
  });

  @override
  List<Object> get props => [filePath, title, description, tags];
}

class ToggleVideoLike extends VideoEvent {
  final String videoId;

  const ToggleVideoLike({required this.videoId});

  @override
  List<Object> get props => [videoId];
}

class LoadMoreVideos extends VideoEvent {}

// States
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoFeedLoaded extends VideoState {
  final List<Video> videos;
  final bool hasReachedMax;

  const VideoFeedLoaded({
    required this.videos,
    this.hasReachedMax = false,
  });

  VideoFeedLoaded copyWith({
    List<Video>? videos,
    bool? hasReachedMax,
  }) {
    return VideoFeedLoaded(
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [videos, hasReachedMax];
}

class VideoError extends VideoState {
  final String message;

  const VideoError({required this.message});

  @override
  List<Object> get props => [message];
}

class VideoUploadInProgress extends VideoState {}

class VideoUploadSuccess extends VideoState {
  final Video video;

  const VideoUploadSuccess({required this.video});

  @override
  List<Object> get props => [video];
}

class VideoUploadFailure extends VideoState {
  final String message;

  const VideoUploadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<LoadVideoFeed>(_onLoadVideoFeed);
    on<UploadNewVideo>(_onUploadNewVideo);
    on<ToggleVideoLike>(_onToggleVideoLike);
    on<LoadMoreVideos>(_onLoadMoreVideos);
  }

  int _currentPage = 0;
  static const int _pageSize = 10;

  Future<void> _onLoadVideoFeed(LoadVideoFeed event, Emitter<VideoState> emit) async {
    if (event.refresh) {
      _currentPage = 0;
      emit(VideoLoading());
    } else if (state is! VideoFeedLoaded) {
      emit(VideoLoading());
    }

    try {
      final videos = await _getMockVideos(page: _currentPage);
      
      if (event.refresh || state is! VideoFeedLoaded) {
        emit(VideoFeedLoaded(
          videos: videos,
          hasReachedMax: videos.length < _pageSize,
        ));
      } else {
        final currentState = state as VideoFeedLoaded;
        emit(currentState.copyWith(
          videos: List.of(currentState.videos)..addAll(videos),
          hasReachedMax: videos.length < _pageSize,
        ));
      }
      
      _currentPage++;
    } catch (e) {
      emit(VideoError(message: e.toString()));
    }
  }

  Future<void> _onUploadNewVideo(UploadNewVideo event, Emitter<VideoState> emit) async {
    emit(VideoUploadInProgress());
    
    try {
      // Simulate video upload
      await Future.delayed(const Duration(seconds: 2));
      
      final newVideo = Video(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x400',
        title: event.title,
        description: event.description,
        uploader: const User(id: 'current_user', name: 'You', email: 'you@example.com'),
        uploadDate: DateTime.now(),
        tags: event.tags,
      );
      
      emit(VideoUploadSuccess(video: newVideo));
      
      // Refresh the feed after successful upload
      add(const LoadVideoFeed(refresh: true));
    } catch (e) {
      emit(VideoUploadFailure(message: e.toString()));
    }
  }

  Future<void> _onToggleVideoLike(ToggleVideoLike event, Emitter<VideoState> emit) async {
    if (state is VideoFeedLoaded) {
      final currentState = state as VideoFeedLoaded;
      final updatedVideos = currentState.videos.map((video) {
        if (video.id == event.videoId) {
          return video.copyWith(
            isLiked: !video.isLiked,
            likesCount: video.isLiked ? video.likesCount - 1 : video.likesCount + 1,
          );
        }
        return video;
      }).toList();
      
      emit(currentState.copyWith(videos: updatedVideos));
      
      // Simulate API call
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        // In a real app, you would make an API call here
      } catch (e) {
        // Revert the optimistic update if the API call fails
        emit(currentState);
      }
    }
  }

  Future<void> _onLoadMoreVideos(LoadMoreVideos event, Emitter<VideoState> emit) async {
    if (state is VideoFeedLoaded) {
      final currentState = state as VideoFeedLoaded;
      if (!currentState.hasReachedMax) {
        add(const LoadVideoFeed());
      }
    }
  }

  // Mock data for demonstration
  Future<List<Video>> _getMockVideos({int page = 0}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final mockVideos = [
      Video(
        id: '${page}_1',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x400',
        title: 'Delicious Pasta Recipe #$page',
        description: 'A quick and easy pasta recipe for weeknights.',
        uploader: const User(id: 'user1', name: 'Chef John', email: 'john@example.com'),
        uploadDate: DateTime.now().subtract(Duration(days: page + 1)),
        likesCount: 120 + page * 10,
        commentsCount: 15 + page * 2,
        tags: const ['pasta', 'italian', 'quick_meal'],
      ),
      Video(
        id: '${page}_2',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x400',
        title: 'Homemade Pizza Challenge #$page',
        description: 'Trying to make the perfect homemade pizza.',
        uploader: const User(id: 'user2', name: 'Foodie Sarah', email: 'sarah@example.com'),
        uploadDate: DateTime.now().subtract(Duration(days: page + 2)),
        likesCount: 250 + page * 15,
        commentsCount: 30 + page * 3,
        tags: const ['pizza', 'baking', 'challenge'],
      ),
    ];
    
    return page < 3 ? mockVideos : []; // Simulate end of data after 3 pages
  }
}

