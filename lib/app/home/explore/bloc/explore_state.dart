part of 'explore_bloc.dart';

@immutable
class ExploreState extends Equatable {
  const ExploreState({
    this.featurePlacesStatus = BlocStatus.initial,
    this.popularPlacesStatus = BlocStatus.initial,
    this.placeCategoryStatus = BlocStatus.initial,
    this.placeCategory = const [],
    this.featurePlaces = const [],
    this.popularPlaces = const [],
  });

  final BlocStatus placeCategoryStatus;
  final BlocStatus featurePlacesStatus;
  final BlocStatus popularPlacesStatus;

  final List<PlaceCategoryModel> placeCategory;
  final List<PlaceModel> featurePlaces;
  final List<PlaceModel> popularPlaces;

  @override
  List<Object?> get props => [
        featurePlacesStatus,
        popularPlacesStatus,
        placeCategoryStatus,
        placeCategory,
        featurePlaces,
        popularPlaces,
      ];

  ExploreState copyWith({
    BlocStatus? placeCategoriesStatus,
    BlocStatus? featureStatus,
    BlocStatus? popularsStatus,
    List<PlaceCategoryModel>? categories,
    List<PlaceModel>? features,
    List<PlaceModel>? populars,
  }) =>
      ExploreState(
        featurePlacesStatus: featureStatus ?? this.featurePlacesStatus,
        popularPlacesStatus: popularsStatus ?? this.popularPlacesStatus,
        placeCategoryStatus: placeCategoriesStatus ?? this.placeCategoryStatus,
        placeCategory: categories ?? this.placeCategory,
        featurePlaces: features ?? this.featurePlaces,
        popularPlaces: populars ?? this.popularPlaces,
      );
}
