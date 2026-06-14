import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/api_service.dart';

class PersonDetailScreen extends StatefulWidget {
  final int personId;

  const PersonDetailScreen({super.key, required this.personId});

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<PersonDetail> _futurePerson;

  @override
  void initState() {
    super.initState();
    _futurePerson = _apiService.getPersonDetail(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PersonDetail>(
        future: _futurePerson,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final person = snapshot.data;

          if (person == null) {
            return const Center(child: Text('No details found'));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: const Color(0xFF0D253F),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    person.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      person.profilePath != null
                          ? Image.network(
                              person.profileUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: const Color(0xFF0D253F)),
                            )
                          : Container(color: const Color(0xFF0D253F)),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xCC0D253F)],
                            stops: [0.4, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoChips(person),
                      const SizedBox(height: 20),
                      Text('Biography', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        (person.biography != null && person.biography!.isNotEmpty)
                            ? person.biography!
                            : 'No biography available.',
                        style: const TextStyle(height: 1.5, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoChips(PersonDetail person) {
    final chips = <Widget>[
      _InfoChip(icon: Icons.work_outline, label: person.knownForDepartment),
    ];

    if (person.birthday != null) {
      chips.add(_InfoChip(icon: Icons.cake_outlined, label: person.birthday!));
    }

    if (person.placeOfBirth != null) {
      chips.add(_InfoChip(icon: Icons.location_on_outlined, label: person.placeOfBirth!));
    }

    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: const Color(0xFF0D253F)),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      backgroundColor: const Color(0xFFE8F0F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    );
  }
}