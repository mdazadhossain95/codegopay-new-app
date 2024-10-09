import 'package:codegopay/Screens/Dashboard_screen/notification_screen.dart';
import 'package:codegopay/Screens/Profile_screen/Profile_screen.dart';
import 'package:codegopay/Screens/Profile_screen/change_password_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/kyc/address_proof/address_proof_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/kyc/face_verify/face_proof_screen.dart';
import 'package:codegopay/Screens/investment/investment_screen.dart';

import '../Screens/Dashboard_screen/Dashboard_screen.dart';
import '../Screens/Dashboard_screen/create_iban_screen.dart';
import '../Screens/Dashboard_screen/iban_kyc_screen.dart';
import '../Screens/Dashboard_screen/transaction_screen.dart';
import '../Screens/Profile_screen/source_of_wealth_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/Setpin_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/kyc/kyc_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/plan_screen.dart';
import 'package:codegopay/Screens/Sign_up_screens/receive_Address.dart';
import 'package:codegopay/Screens/Sign_up_screens/step_one.dart';
import 'package:codegopay/Screens/Sign_up_screens/verify_email.dart';
import 'package:codegopay/Screens/Splash_screen/Splash_screen.dart';
import 'package:codegopay/Screens/Splash_screen/Welcom_screen.dart';
import 'package:codegopay/Screens/gift_card/buy_gift_card_details_screen.dart';
import 'package:codegopay/Screens/gift_card/buy_gift_card_screen.dart';
import 'package:codegopay/Screens/login_screen/Getpin_screen.dart';
import 'package:codegopay/Screens/login_screen/login_screen.dart';
import 'package:codegopay/Screens/transfer_screen/done_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/Sign_up_screens/kyc/kyc_status_check_screen.dart';
import '../Screens/Sign_up_screens/kyc/kyc_submit_screen.dart';
import '../Screens/Sign_up_screens/signup_section/kyc_start_screen.dart';
import '../Screens/Sign_up_screens/signup_section/kyc_welcome_screen.dart';
import '../Screens/Sign_up_screens/signup_section/signup_screen.dart';
import '../Screens/Sign_up_screens/signup_section/signup_userinfo_page1_screen.dart';
import '../Screens/Sign_up_screens/signup_section/signup_userinfo_page2_screen.dart';
import '../Screens/Sign_up_screens/signup_section/signup_userinfo_page3_screen.dart';
import '../Screens/card_screen_test/card_request_screen.dart';
import '../Screens/card_screen_test/card_screen.dart';
import '../Screens/card_screen_test/card_settings_screen.dart';
import '../Screens/card_screen_test/card_verify_getpin_screen.dart';
import '../Screens/card_screen_test/debit_card_screen.dart';
import '../Screens/card_screen_test/perpaid_card_beneficiary_screen.dart';
import '../Screens/card_screen_test/prepaid_card_activated_screen.dart';
import '../Screens/crypto_screen/Crypto_screen.dart';
import '../Screens/gift_card/show_gift_card_screen.dart';
import '../Screens/investment/master_node_dashboard_screen.dart';
import '../Screens/login_screen/forgot_password_screen.dart';
import '../Screens/transfer_screen/add_binficary.dart';
import '../Screens/transfer_screen/binficiary_screen.dart';

Route generatroutecustomRoute(
  RouteSettings settings,
) {
  switch (settings.name) {
    case '/':
      return PageTransition(
        child: const SplashScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'WelcomeScreen':
      return PageTransition(
        child: const WelcomeScreen(),
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'login':
      return PageTransition(
        child: const LoginScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'signup':
      return PageTransition(
        child: const SteponeScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    // case 'Step2':
    //   return PageTransition(
    //     child: const SteptwoScreen(),
    //     type: PageTransitionType.bottomToTop,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 300),
    //     reverseDuration: const Duration(milliseconds: 200),
    //   );

    // case 'Step3':
    //   return PageTransition(
    //     child: const StepthreeScreen(),
    //     type: PageTransitionType.bottomToTop,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 300),
    //     reverseDuration: const Duration(milliseconds: 200),
    //   );
    case 'Step4':
      return PageTransition(
        child: const SourceOfWealthScreen(),
        type: PageTransitionType.rightToLeftWithFade,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );


    case 'Shippingaddress':
      return PageTransition(
        child: const ShippingAddressScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'verifyotp':
      return PageTransition(
        child: const VerifyemailScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    // case 'firstkyc':
    //   return PageTransition(
    //     child: const KycSendScreen(),
    //     type: PageTransitionType.bottomToTop,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 300),
    //     reverseDuration: const Duration(milliseconds: 200),
    //   );

    // case 'rejectkyc':
    //   return PageTransition(
    //     child: const KycRejectScreen(),
    //     type: PageTransitionType.bottomToTop,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 300),
    //     reverseDuration: const Duration(milliseconds: 200),
    //   );

    case 'setpin':
      return PageTransition(
        child: const SetpinScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'planscreen':
      return PageTransition(
        child: const PlanScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'getpin':
      return PageTransition(
        child: const GetpinScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'dashboard':
      return PageTransition(
        child: const DashboardScreen(),
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'donescreen':
      return PageTransition(
        child: const DoneScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'buyGiftCardScreen':
      return PageTransition(
        child: const BuyGiftCardScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'buyGiftCardDetailsScreen':
      return PageTransition(
        child: const BuyGiftCardDetailsScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    // case 'buyGiftCardConfirmScreen':
    //   return PageTransition(
    //     child: const BuyGiftCardConfirmDetailsScreen(),
    //     type: PageTransitionType.bottomToTop,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 300),
    //     reverseDuration: const Duration(milliseconds: 200),
    //   );

    case 'userGiftCardDetailsScreen':
      return PageTransition(
        child: const ShowGiftCardScreen(),
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'kycScreen':
      return PageTransition(
        child: const KycScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'addressProofScreen':
      return PageTransition(
        child: const AddressProofScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'faceProofScreen':
      return PageTransition(
        child: const FaceProofScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'kycSubmitScreen':
      return PageTransition(
        child: const KycSubmitScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'kycCheckStatusScreen':
      return PageTransition(
        child: const KycCheckStatusScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'cardScreen':
      return PageTransition(
        child: const CardScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    //card test checking
    case 'cardRequestScreen':
      return PageTransition(
        child: const CardRequestScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'debitCardScreen':
      return PageTransition(
        child: const DebitCardScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'prepaidCardActivatedScreen':
      return PageTransition(
        child: const PrepaidCardActivatedScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'cardSettingsScreen':
      return PageTransition(
        child: const CardSettingsScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'cardVerifyGetPinScreen':
      return PageTransition(
        child: const CardVerifyGetPinScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'prepaidCardBeneficiaryScreen':
      return PageTransition(
        child: const PrepaidCardBeneficiaryScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'transactionScreen':
      return PageTransition(
        child: const TransactionScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'signUpScreen':
      return PageTransition(
        child: const SignupScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'signUpUserInfoPage1Screen':
      return PageTransition(
        child: const SignupUserInfoPage1Screen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'signUpUserInfoPage2Screen':
      return PageTransition(
        child: const SignupUserInfoPage2Screen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'signUpUserInfoPage3Screen':
      return PageTransition(
        child: const SignupUserInfoPage3Screen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'kycWelcomeScreen':
      return PageTransition(
        child: const KycWelcomeScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'kycStartScreen':
      return PageTransition(
        child: const KycStartScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'createIbanScreen':
      return PageTransition(
        child: const CreateIbanScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'ibanKycScreen':
      return PageTransition(
        child: const IbanKycScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
      case 'forgotPasswordScreen':
      return PageTransition(
        child: const ForgotPasswordScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

      case 'changePasswordScreen':
      return PageTransition(
        child: const ChangePasswordScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'investmentScreen':
      return PageTransition(
        child: const InvestmentScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
    case 'beneficiaryListScreen':
      return PageTransition(
        child: const BeneficiaryListScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
      case 'addBeneficiaryScreen':
      return PageTransition(
        child: const AddBeneficiaryScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
      case 'cryptoScreen':
      return PageTransition(
        child: const CryptoScreen(),
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    case 'notificationScreen':
      return PageTransition(
        child: const NotificationScreen(),
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
      case 'masterNodeScreen':
      return PageTransition(
        child: const MasterNodeDashboardScreen(),
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );
      case 'profileScreen':
      return PageTransition(
        child: const ProfileScreen(),
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
      );

    // break;
    default:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
