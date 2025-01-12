import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

class MailProvider with ChangeNotifier {
  String _otp = '';

  initSmptServer() {
    EmailOTP.setSMTP(
      host: 'yadah-consulting.com',
      emailPort: EmailPort.port465,
      secureType: SecureType.ssl,
      username: 'email@yadah-consulting.com',
      password: 'By{SjGyx1qEX',
    );
  }

  sendOtpEmail(String userEmail) async {
    initSmptServer();

    EmailOTP.config(
      appName: 'Hakika',
      appEmail: 'email@yadah-consulting.com',
      otpType: OTPType.numeric,
      emailTheme: EmailTheme.v1,
      otpLength: 4,
    );

    EmailOTP.sendOTP(email: userEmail);
  }
}
