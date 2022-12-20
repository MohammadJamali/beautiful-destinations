import 'package:beautiful_destinations/repositories/failures/place_failures.dart';
import 'package:beautiful_destinations/repositories/models/place.dart';
import 'package:beautiful_destinations/repositories/models/video_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceRepository {
  PlaceRepository(FirebaseFirestore instance);

  Future<List<PlaceModel>> hotels() async {
    try {
      return List.empty();
    } catch (e, s) {
      throw PlaceFailures(e, s);
    }
  }

  Future<List<PlaceModel>> features() async {
    try {
      return List.empty();
    } catch (e, s) {
      throw PlaceFailures(e, s);
    }
  }

  Future<List<PlaceModel>> populars() async {
    try {
      return List.empty();
    } catch (e, s) {
      throw PlaceFailures(e, s);
    }
  }

  Future<List<PlaceCategoryModel>> categories() async {
    try {
      return List.empty();
    } catch (e, s) {
      throw PlaceFailures(e, s);
    }
  }
}
