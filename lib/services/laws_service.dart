import 'package:baguette/models/law_model.dart';
import 'package:uuid/uuid.dart';

abstract class LawsService {
  Future<List<Law>> getFeaturedLaws();
  Future<Law> getLawById(String id);
}

class MockLawsService implements LawsService {
  final _uuid = const Uuid();

  @override
  Future<List<Law>> getFeaturedLaws() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.generate(10, (index) => _generateMockLaw(index));
  }

  @override
  Future<Law> getLawById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _generateMockLaw(0, id: id);
  }

  Law _generateMockLaw(int index, {String? id}) {
    return Law(
      id: id ?? _uuid.v4(),
      title: 'Projet de loi relatif à la transition énergétique #$index',
      summary:
          'Ce projet vise à accélérer la production d\'énergies renouvelables.',
      description:
          'Une description longue et détaillée du projet de loi qui explique les enjeux, les mesures proposées et les impacts attendus sur la société française. Il s\'agit de réduire notre dépendance aux énergies fossiles.',
      authors: ['Jean Dupont', 'Marie Curie'],
      group: 'Ecologie et Solidarité',
      status: index % 2 == 0 ? 'seance' : 'commission',
      createdAt: DateTime.now().subtract(Duration(days: index * 2)),
      sourceUrl: 'https://www.assemblee-nationale.fr',
    );
  }
}
