import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void updateSearchQuery(String query) {
    emit(query.toLowerCase());
  }
}
