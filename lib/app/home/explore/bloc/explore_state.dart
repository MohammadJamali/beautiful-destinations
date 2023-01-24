part of 'explore_bloc.dart';

@immutable
class ExploreState extends Equatable {
  const ExploreState({
    this.featureStatus = BlocStatus.initial,
    this.popularsStatus = BlocStatus.initial,
    this.categoriesStatus = BlocStatus.initial,
    this.categories = const [],
    this.features = const [],
    this.populars = const [],
  });

  final BlocStatus categoriesStatus;
  final BlocStatus featureStatus;
  final BlocStatus popularsStatus;

  final List<PlaceCategoryModel> categories;
  final List<PlaceModel> features;
  final List<PlaceModel> populars;

  @override
  List<Object?> get props => [
        featureStatus,
        popularsStatus,
        categoriesStatus,
        categories,
        features,
        populars,
      ];

  ExploreState copyWith({
    BlocStatus? categoriesStatus,
    BlocStatus? featureStatus,
    BlocStatus? popularsStatus,
    List<PlaceCategoryModel>? categories,
    List<PlaceModel>? features,
    List<PlaceModel>? populars,
  }) =>
      ExploreState(
        featureStatus: featureStatus ?? this.featureStatus,
        popularsStatus: popularsStatus ?? this.popularsStatus,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        categories: categories ?? this.categories,
        features: features ?? this.features,
        populars: populars ?? this.populars,
      );
}
