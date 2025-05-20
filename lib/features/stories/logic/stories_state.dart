part of 'stories_cubit.dart';

@immutable
abstract class StoriesState {}

class StoriesInitial extends StoriesState {}
class StoriesLoading extends StoriesState {}
class StoriesLoaded extends StoriesState {
  final List<StoriesModel> stories;
  StoriesLoaded(this.stories);
}
class StoriesError extends StoriesState {
  final String error;
  StoriesError(this.error);
}
class StoriesEmpty extends StoriesState {}
