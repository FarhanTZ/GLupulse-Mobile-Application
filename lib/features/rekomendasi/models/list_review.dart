
import 'Review.dart'; // Import the Review model

List<Review> reviews = [
  Review(
    name: 'Kakayak',
    profileImage: 'assets/reviewers/reviewer1.jpg',  // Path to the reviewer's profile image
    reviewDate: '1 day ago',
    rating: 4.5,
    reviewText: 'Great doctor! Very knowledgeable and helpful. I felt very comfortable during the consultation.',
  ),
  Review(
    name: 'Siti Aisyah',
    profileImage: 'assets/reviewers/reviewer2.jpg',  // Path to the reviewer's profile image
    reviewDate: '3 days ago',
    rating: 5.0,
    reviewText: 'Excellent experience! The doctor explained everything clearly and took the time to listen to my concerns.',
  ),
  Review(
    name: 'John Michael',
    profileImage: 'assets/reviewers/reviewer3.jpg',  // Path to the reviewer's profile image
    reviewDate: '1 week ago',
    rating: 4.0,
    reviewText: 'Good doctor, but the wait time was a bit long. However, the consultation was thorough and helpful.',
  ),
];
