import '../models/grooming_model.dart';
import '../providers/grooming_provider.dart';

class GroomingRepository {
  final GroomingProvider groomingProvider;
  GroomingRepository({required this.groomingProvider});

  Future<List<Grooming>> getGroomingModelList(String petId) async {
    final groomingData = await groomingProvider.getGrooming(petId);
    final groomingQuery = groomingData.docs;
    return groomingQuery
        .map((grooming) => Grooming.fromJson(grooming.id, grooming.data()))
        .toList();
  }

  Future<void> uploadGroomingMap(Grooming grooming) async {
    final groomingMap = Grooming.toJson(grooming);
    await groomingProvider.uploadGrooming(grooming.groomingId, groomingMap);
  }

  Future<void> deleteGrooming(String groomingId) async {
    await groomingProvider.deleteGrooming(groomingId);
  }
}
