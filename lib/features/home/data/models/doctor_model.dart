class DoctorModel {
  final String name;
  final String specialization;
  final String imageUrl;
  final double rating;
  final int yearsOfExperience;
  final String location;

  const DoctorModel({
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.yearsOfExperience,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'rating': rating,
      'yearsOfExperience': yearsOfExperience,
      'location': location,
    };
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      specialization: json['specialization'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      yearsOfExperience: json['yearsOfExperience'],
      location: json['location'],
    );
  }
}