import 'package:baguette/models/deputy_model.dart';

abstract class DeputiesService {
  Future<List<Deputy>> getAllDeputies();
  Future<Deputy> getDeputyById(String id);
}

class MockDeputiesService implements DeputiesService {
  @override
  Future<List<Deputy>> getAllDeputies() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.generate(20, (index) => _generateMockDeputy(index));
  }

  @override
  Future<Deputy> getDeputyById(String id) async {
    return _generateMockDeputy(0, id: id);
  }

  Deputy _generateMockDeputy(int index, {String? id}) {
    return Deputy(
      id: id ?? 'deputy_$index',
      name: 'Député Exemplaire $index',
      group: 'Groupe Démocrate',
      region: 'Circonscription ${index + 1}',
      photoUrl: 'https://i.pravatar.cc/150?u=$index',
      bio: 'Un député engagé pour sa circonscription depuis plusieurs années.',
      cohesionScore: 0.85 + (index % 15) / 100,
    );
  }
}
