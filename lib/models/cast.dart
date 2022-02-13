class Cast {
  
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;
    

  String get fullProfilePath => 
    profilePath != null  
      ? 'https://image.tmdb.org/t/p/w500$profilePath'
      : 'https://i.stack.imgur.com/GNhxO.png';
  

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });


  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] ?? null,
    castId: json["cast_id"] ?? null,
    character: json["character"] ?? null,
    creditId: json["credit_id"],
    order: json["order"] ?? null,
    department: json["department"] ?? null,
    job: json["job"] ?? null,
  );
}