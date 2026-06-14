// Model for a single person in the "popular people" list
class Person {
  final int id;
  final String name;
  final String? profilePath;
  final double popularity;
  final String knownForDepartment;

  Person({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      knownForDepartment: json['known_for_department'] ?? '',
    );
  }

  // Full image URL for the person's profile picture
  String get profileUrl => profilePath != null
      ? 'https://image.tmdb.org/t/p/w185$profilePath'
      : '';
}

// Wraps the full response from /person/popular
class PopularPeopleResponse {
  final int page;
  final List<Person> results;
  final int totalPages;
  final int totalResults;

  PopularPeopleResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularPeopleResponse.fromJson(Map<String, dynamic> json) {
    return PopularPeopleResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

// Model for the detailed response from /person/{person_id}
class PersonDetail {
  final int id;
  final String name;
  final String? biography;
  final String? birthday;
  final String? deathday;
  final String? placeOfBirth;
  final String? profilePath;
  final double popularity;
  final String knownForDepartment;

  PersonDetail({
    required this.id,
    required this.name,
    this.biography,
    this.birthday,
    this.deathday,
    this.placeOfBirth,
    this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
  });

  factory PersonDetail.fromJson(Map<String, dynamic> json) {
    return PersonDetail(
      id: json['id'],
      name: json['name'] ?? '',
      biography: json['biography'],
      birthday: json['birthday'],
      deathday: json['deathday'],
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      knownForDepartment: json['known_for_department'] ?? '',
    );
  }

  String get profileUrl => profilePath != null
      ? 'https://image.tmdb.org/t/p/w300$profilePath'
      : '';
}