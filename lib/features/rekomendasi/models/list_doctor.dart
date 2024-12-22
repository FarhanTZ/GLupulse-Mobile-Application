import 'doctor.dart';

List<Doctor> doctors = [
  Doctor(
    name: 'Dr. John Doe',
    specialty: 'General Practitioner',
    profileImage: 'assets/doctor/doctor_profile.jpg',
    rating: 4.5,
    bio: 'Dr. John Doe has over 10 years of experience in general practice and is dedicated to providing excellent care to all of his patients.',
    location: 'City Hospital',
    addres:  ' 123 Main St, Springfield',
    price: '70'
  ),
  Doctor(
    name: 'Dr. Jane Smith',
    specialty: 'Pediatrician',
    profileImage: 'assets/doctor/doctor_profile2.jpg',
    rating: 4.7,
    bio: 'Dr. Jane Smith specializes in pediatrics and is passionate about helping children achieve their best health.',
    location: 'Pediatric Care Center',
    addres: '456 Elm St, Rivertown',
    price: '52', // Full location
  ),
  Doctor(
    name: 'Dr. Sarah Lee',
    specialty: 'Cardiologist',
    profileImage: 'assets/doctor/doctor_profile3.jpg',
    rating: 4.8,
    bio: 'Dr. Sarah Lee is an experienced cardiologist who is committed to helping patients manage their heart health.',
    location: 'Heart Care Clinic,',
    addres: '789 Oak Ave, Downtown',
    price:'60', // Full location
  ),
  Doctor(
    name: 'Dr. Adinda Criss',
    specialty: 'Cardiologist',
    profileImage: 'assets/doctor/doctor_profile4.jpg',
    rating: 4.9,
    bio: 'Dr. Adinda Criss has a deep understanding of cardiology and is known for her empathetic approach towards her patients.',
    location: 'Cardio Health Center',
    addres: '101 Pine Rd, Westside',
    price: '50' // Full location
  ),
];
