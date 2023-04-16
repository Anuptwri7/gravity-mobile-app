class CustomerProfile {
  int id;
  String fullName;
  String email;
  String phoneNo;
  String address;
  String photo;

  CustomerProfile(
      {this.id,
        this.fullName,
        this.email,
        this.phoneNo,
        this.address,
        this.photo});

  CustomerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    address = json['address'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['photo'] = this.photo;
    return data;
  }
}