import 'package:flutter/material.dart';
import '../screens/onboarding/splash_screen.dart';
import '../screens/onboarding/landing_screen.dart';
import '../screens/onboarding/signup_screen.dart';
import '../screens/onboarding/otp_verification_screen.dart';
import '../screens/kyc/vehicle_type_screen.dart';
import '../screens/kyc/personal_info_screen.dart';
import '../screens/kyc/dl_info_screen.dart';
import '../screens/kyc/dl_upload_screen.dart';
import '../screens/kyc/aadhaar_info_screen.dart';
import '../screens/kyc/aadhaar_upload_screen.dart';
import '../screens/kyc/vehicle_info_screen.dart';
import '../screens/kyc/vehicle_photos_screen.dart';
import '../screens/kyc/rc_upload_screen.dart';
import '../screens/kyc/kyc_status_screen.dart';
import '../screens/main/main_shell_screen.dart';
import '../screens/main/ride_requests_screen.dart';
import '../screens/main/active_ride_pickup_screen.dart';
import '../screens/main/active_ride_transit_screen.dart';
import '../screens/main/bank_details_screen.dart';
import '../screens/main/personal_documents_screen.dart';
import '../screens/main/vehicle_documents_screen.dart';
import '../screens/main/notifications_screen.dart';

/// Centralized route names and route generation for the app.
class AppRoutes {
  AppRoutes._();

  // ── Route Names ──────────────────────────────────────────────
  static const String splash = '/';
  static const String landing = '/landing';
  static const String signup = '/signup';
  static const String otpVerification = '/otp-verification';

  // KYC Wizard
  static const String kycVehicleType = '/kyc/vehicle-type';
  static const String kycPersonalInfo = '/kyc/personal-info';
  static const String kycDlInfo = '/kyc/dl-info';
  static const String kycDlUpload = '/kyc/dl-upload';
  static const String kycAadhaarInfo = '/kyc/aadhaar-info';
  static const String kycAadhaarUpload = '/kyc/aadhaar-upload';
  static const String kycVehicleInfo = '/kyc/vehicle-info';
  static const String kycVehiclePhotos = '/kyc/vehicle-photos';
  static const String kycRcUpload = '/kyc/rc-upload';
  static const String kycStatus = '/kyc/status';

  // Main App
  static const String mainApp = '/main';
  static const String rideRequests = '/ride-requests';
  static const String activeRidePickup = '/active-ride/pickup';
  static const String activeRideTransit = '/active-ride/transit';
  static const String bankDetails = '/bank-details';
  static const String personalDocuments = '/personal-documents';
  static const String vehicleDocuments = '/vehicle-documents';
  static const String notifications = '/notifications';

  // ── Route Generator ──────────────────────────────────────────
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case splash:
        page = const SplashScreen();
        break;
      case landing:
        page = const LandingScreen();
        break;
      case signup:
        page = const SignupScreen();
        break;
      case otpVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        page = OtpVerificationScreen(phoneNumber: args?['phoneNumber'] ?? '');
        break;
      case kycVehicleType:
        page = const VehicleTypeScreen();
        break;
      case kycPersonalInfo:
        page = const PersonalInfoScreen();
        break;
      case kycDlInfo:
        page = const DlInfoScreen();
        break;
      case kycDlUpload:
        page = const DlUploadScreen();
        break;
      case kycAadhaarInfo:
        page = const AadhaarInfoScreen();
        break;
      case kycAadhaarUpload:
        page = const AadhaarUploadScreen();
        break;
      case kycVehicleInfo:
        page = const VehicleInfoScreen();
        break;
      case kycVehiclePhotos:
        page = const VehiclePhotosScreen();
        break;
      case kycRcUpload:
        page = const RcUploadScreen();
        break;
      case kycStatus:
        page = const KycStatusScreen();
        break;
      case mainApp:
        page = const MainShellScreen();
        break;
      case rideRequests:
        page = const RideRequestsScreen();
        break;
      case activeRidePickup:
        page = const ActiveRidePickupScreen();
        break;
      case activeRideTransit:
        page = const ActiveRideTransitScreen();
        break;
      case bankDetails:
        page = const BankDetailsScreen();
        break;
      case personalDocuments:
        page = const PersonalDocumentsScreen();
        break;
      case vehicleDocuments:
        page = const VehicleDocumentsScreen();
        break;
      case notifications:
        page = const NotificationsScreen();
        break;
      default:
        page = const SplashScreen();
    }

    return _buildSlideTransition(page, settings);
  }

  /// Smooth slide-in from right transition for all screen navigations.
  static PageRouteBuilder _buildSlideTransition(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
