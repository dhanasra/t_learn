
import 'package:flutter/material.dart';

const appAssets = "assets/images/";
const razorpayKey = 'rzp_live_MwuQI6Cccr10ql';

const primaryColor = Color(0xFF2066FF);
const secondaryColor = Color(0xFF01147C);

const tcPrimary = Color(0xFF6B60F1);
const tcBlack = Color(0xFF000000);
const tcGrey = Color(0xFFF0F0F0);
const tcWhite = Color(0xFFFFFFFF);
const promptColor = Color(0xFFD0D0D0);

const kbcAmountStyle =  TextStyle(
  color: Colors.yellow,
  fontFamily: 'Freshman',
  fontWeight: FontWeight.w600,
  fontSize: 20,
);

const levelTextStyle =  TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w800,
  fontSize: 14
);

const levelHeaderTextStyle = TextStyle(
color: Colors.black,
fontWeight: FontWeight.w500,
fontFamily: 'Freshman',
fontSize: 14,
);

const appGradient = LinearGradient(
    colors: [Color(0xFF01147C),Color(0xFF0000FD),Color(0xFF01147C)],
    stops: [0,0.5, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);

const appGradient2 = LinearGradient(
    colors: [Color(0xFF01147C),Color(0xFF0000FD),Color(0xFF01147C)],
    stops: [0,0.5, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);

const appGradient3 = LinearGradient(
    colors: [Color(0xFFD2691E),Color(0xFFFFA500),Color(0xFFD2691E)],
    stops: [0,0.5, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);

const appGradient5 = LinearGradient(
    colors: [Color(0xFFFFA500),Color(0xFFD2691E),Color(0xFFFFA500)],
    stops: [0,0.5, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);

const rg = RadialGradient(
  center: Alignment(0,0),
  radius: 5,
  stops: [0.0, 1],
  colors: [
    Color(0xFF082160),
    Color(0xFF4949FF),
  ],
);

const rgSuccess = RadialGradient(
  center: Alignment(0,0),
  radius: 5,
  stops: [0.0, 1],
  colors: [
    Color(0xFF006400),
    Color(0xFF2E8B57),
  ],
);

const rgFailure = RadialGradient(
  center: Alignment(0,0),
  radius: 5,
  stops: [0.0, 1],
  colors: [
    Color(0xFFD22B2B),
    Color(0xFFEE4B2B),
  ],
);

const rg1 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0,0.2,0.4,0.6, 1],
  colors: [
    Color(0xFF6A359C),
    Color(0xFF552586),
    Color(0xFF804FB3),
    Color(0xFF9969C7),
    Color(0xFF800080),
  ],
);

const lineGradientR = LinearGradient(
    colors: [Color(0xFFFFFFFF),Color(0x22FFFFFF)],
    stops: [0,1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight
);

const lineGradientL = LinearGradient(
    colors: [Color(0xFFFFFFFF),Color(0x22FFFFFF)],
    stops: [0,1],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft
);

const appGradient4 = LinearGradient(
    colors: [Color(0xFFFFA500),Color(0xFFFFFF00),Color(0xFFFFA500)],
    stops: [0,0.5, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);

const double blunt = 8;
const double circle = 100;

const commonAvatar = "https://firebasestorage.googleapis.com/v0/b/tlearn-d688e.appspot.com/o/app_images%2Fman%20(1).png?alt=media&token=9c181f09-6120-4ee6-8dc0-51f1c6597dfa";

const telegramLink = "https://telegram.me/padiapp";

const instaLink = "https://www.instagram.com/padi.app/";

const mailto = "padiapp.contact@gmail.com";

const List<String> kbcCoins = [
  "10",
  "20",
  "50",
  "75",
  "100",
  "150",
  "200",
  "275",
  "350",
  "500",
  "650",
  "700",
  "775",
  "850",
  "1000"
];