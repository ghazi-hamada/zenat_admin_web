import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/core/class/crud.dart';
import 'package:zenat_admin_web/core/class/post_data.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/stories/data/StoriesModel.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit() : super(StoriesInitial());
  PostData postData = PostData(Crud());
  List<StoriesModel> stories = [];

  void fetchStories() async {
    emit(StoriesLoading());
    var response = await postData.postData(
      linkurl: AppApiString.STORIES,
      data: {},
    );
    response.fold((l) => emit(StoriesError(l)), (r) {
      if (r['status'] == 'success') {
        stories =
            (r['data'] as List).map((e) => StoriesModel.fromJson(e)).toList();
        if (stories.isEmpty) {
          emit(StoriesEmpty());
        }
        emit(StoriesLoaded(stories));
      } else {
        emit(StoriesError(r['message']));
      }
    });
  }

  void deleteStory({required String storyId}) async {
    emit(StoriesLoading());
    var response = await postData.postData(
      linkurl: AppApiString.DELETE_STORY,
      data: {'idStory': storyId.toString()},
    );
    response.fold((l) => emit(StoriesError(l)), (r) {
      if (r['status'] == 'success') {
        emit(StoriesLoaded(stories));
      } else {
        emit(StoriesError(r['message']));
      }
    });
  }
}
