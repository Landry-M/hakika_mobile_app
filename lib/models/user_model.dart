class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String eventId;
  final bool isLogin;
  final bool otpEntered;
  final bool firstLaunchApp;
  final bool appBlocked;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.eventId,
    required this.isLogin,
    required this.otpEntered,
    required this.firstLaunchApp,
    required this.appBlocked,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      eventId: json['event_id'] ?? '',
      isLogin: json['is_login'] ?? false,
      otpEntered: json['otp_entered'] ?? false,
      firstLaunchApp: json['first_launch_app'] ?? false,
      appBlocked: json['app_blocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'event_id': eventId,
      'is_login': isLogin,
      'otp_entered': otpEntered,
      'first_launch_app': firstLaunchApp,
      'app_blocked': appBlocked
    };
  }

  UserModel copy(
          {String? userId,
          String? name,
          String? email,
          String? phone,
          String? role,
          String? eventId,
          bool? isLogin,
          bool? otpEntered,
          bool? firstLaunchApp,
          bool? appBlocked}) =>
      UserModel(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        eventId: eventId ?? this.eventId,
        isLogin: isLogin ?? this.isLogin,
        otpEntered: otpEntered ?? this.otpEntered,
        firstLaunchApp: firstLaunchApp ?? this.firstLaunchApp,
        appBlocked: appBlocked ?? this.appBlocked,
      );
}
