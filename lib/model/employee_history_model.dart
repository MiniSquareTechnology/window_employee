class EmployeeHistoryModel {
  int? statusCode;
  String? status;
  String? message;
  List<Data>? data;

  EmployeeHistoryModel({this.statusCode, this.status, this.message, this.data});

  EmployeeHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? employeeId;
  String? dateTime;
  String? status;
  var lastActive;
  String? createdAt;
  String? updatedAt;
  String? serverTime;
  String? totalHours;
  User? user;

  Data(
      {this.id,
        this.userId,
        this.employeeId,
        this.dateTime,
        this.status,
        this.lastActive,
        this.createdAt,
        this.updatedAt,
        this.serverTime,
        this.totalHours,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    dateTime = json['date_time'];
    status = json['status'];
    lastActive = json['last_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serverTime = json['server_time'];
    totalHours = json['total_hours'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['date_time'] = this.dateTime;
    data['status'] = this.status;
    data['last_active'] = this.lastActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['server_time'] = this.serverTime;
    data['total_hours'] = this.totalHours;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  var firstName;
  var lastName;
  String? username;
  String? email;
  var phoneCode;
  var isoCode;
  var phoneNumber;
  int? employeeId;
  var profileImage;
  var dob;
  var gender;
  var address;
  var latitude;
  var longitude;
  var country;
  var city;
  var state;
  var height;
  int? notification;
  int? role;
  int? status;
  int? type;
  var emailVerifiedAt;
  var emailVerificationOtp;
  int? deviceType;
  var fcmToken;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var createdBy;
  String? customStatus;
  String? customStatusTitle;

  User(
      {this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.phoneCode,
        this.isoCode,
        this.phoneNumber,
        this.employeeId,
        this.profileImage,
        this.dob,
        this.gender,
        this.address,
        this.latitude,
        this.longitude,
        this.country,
        this.city,
        this.state,
        this.height,
        this.notification,
        this.role,
        this.status,
        this.type,
        this.emailVerifiedAt,
        this.emailVerificationOtp,
        this.deviceType,
        this.fcmToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.customStatus,
        this.customStatusTitle});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    phoneCode = json['phone_code'];
    isoCode = json['iso_code'];
    phoneNumber = json['phone_number'];
    employeeId = json['employee_id'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    height = json['height'];
    notification = json['notification'];
    role = json['role'];
    status = json['status'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    emailVerificationOtp = json['email_verification_otp'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    customStatus = json['custom_status'];
    customStatusTitle = json['custom_status_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_code'] = this.phoneCode;
    data['iso_code'] = this.isoCode;
    data['phone_number'] = this.phoneNumber;
    data['employee_id'] = this.employeeId;
    data['profile_image'] = this.profileImage;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['height'] = this.height;
    data['notification'] = this.notification;
    data['role'] = this.role;
    data['status'] = this.status;
    data['type'] = this.type;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['custom_status'] = this.customStatus;
    data['custom_status_title'] = this.customStatusTitle;
    return data;
  }
}
