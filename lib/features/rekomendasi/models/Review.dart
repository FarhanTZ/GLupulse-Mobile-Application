class Review {
  final String name;
  final String profileImage;
  final String reviewDate; // For example: "1 day ago"
  final double rating;
  final String reviewText;

  Review({
    required this.name,
    required this.profileImage,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
  });
}
