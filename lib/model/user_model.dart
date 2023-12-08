class UserModel {
  var statusCode;
  String? status;
  String? message;
  Data? data;

  UserModel({this.statusCode, this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var id;
  var username;
  String? fullName;
  String? email;
  var profileImage;
  var role;
  var status;
  var emailVerificationOtp;
  var notification;
  var emailNotification;
  var emailVerifiedAt;
  var type;
  var height;
  var dob;
  var createdAt;
  var updatedAt;
  String? authToken;

  Data(
      {this.id,
        this.username,
        this.fullName,
        this.email,
        this.profileImage,
        this.role,
        this.status,
        this.emailVerificationOtp,
        this.notification,
        this.emailNotification,
        this.emailVerifiedAt,
        this.type,
        this.height,
        this.dob,
        this.createdAt,
        this.updatedAt,
        this.authToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    role = json['role'];
    status = json['status'];
    emailVerificationOtp = json['email_verification_otp'];
    notification = json['notification'];
    emailNotification = json['email_notification'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    height = json['height'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['role'] = this.role;
    data['status'] = this.status;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['notification'] = this.notification;
    data['email_notification'] = this.emailNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type'] = this.type;
    data['height'] = this.height;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['auth_token'] = this.authToken;
    return data;
  }
}
