class UserModel {
  final String uid;
  final String email;
  final String name;
  final int age;
  final DateTime startDate;
  final int availableLevels;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.age,
      required this.startDate,
      required this.availableLevels});
}
