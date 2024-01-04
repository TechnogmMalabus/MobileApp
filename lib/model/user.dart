class User {
  String id;
  String fname;
  String lname;
  String email;
  late String password;
  String username;
  String birthday;
  String phoneNum;
  String job;
  String civility;
  String address;
  String postalCode;
  String city;
  String country;

  User(
      {required this.id,
      required this.fname,
      required this.lname,
      required this.email,
      required this.username,
      required this.birthday,
      required this.phoneNum,
      required this.job,
      required this.civility,
      required this.address,
      required this.postalCode,
      required this.city,
      required this.country});

  @override
  String toString() {
    return 'User{id: $id, fname: $fname, lname: $lname, email: $email, username: $username, birthday: $birthday, phoneNum: $phoneNum, job: $job, civility: $civility, address: $address, postalCode: $postalCode, city: $city, country: $country}';
  }
}
