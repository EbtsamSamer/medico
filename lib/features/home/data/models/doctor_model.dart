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
}