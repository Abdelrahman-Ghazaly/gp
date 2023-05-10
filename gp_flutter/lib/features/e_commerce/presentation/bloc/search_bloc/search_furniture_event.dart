part of 'search_furniture_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetFurnitireFromSearchEvent extends SearchEvent {
  final QueryEntity queryEntity;

  const GetFurnitireFromSearchEvent({required this.queryEntity});

  @override
  List<Object> get props => [queryEntity];
}
