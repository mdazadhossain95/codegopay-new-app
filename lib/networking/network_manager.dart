import 'dart:convert';

import 'package:codegopay/Models/application.dart';
import 'package:codegopay/Screens/no_network_connection/no_network_connection.dart';
import 'package:codegopay/Screens/no_network_connection/server_error_screen.dart';
import 'package:codegopay/utils/connectionStatusSingleton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppConfig {
  // /countries_get
  static String baseUrl =
      "https://api7645348654.codegotech.com/new_cardapi/"; // For cardapi
  static String subBaseUrl = "https://api7645348654.codegotech.com/new_cardapi";

  static const String version = "/api/v1/";
  static const String authKey =
      "thebank20201234567891011121crypto07a932dd17adc59b49561f";
  static const String secretKey =
      "thebank20201234567891011121crypto07a932dd17adc59b49561f";
  static const String whiteLabel =
      "9b7a9e52-5b13eb6e-107a5683-1a4c73a8-d0238ee7-bb0a6746-33a08089-a6b0f363";

  static const String endPointCountriesApi = 'iban_countries_get';
  static const String endPointIncomeSource = 'income_source';
  static const String endPointMobileVerify = 'mobileverify';
  static const String endPointOTPemail = 'iban_singup_email';
  static const String endPointincomesource = 'income_source';
  static const String endPointsourcefund = 'iban_sorucefund';
  static const String updateSof = 'sdkkyc_updateSource';

  static const String endPointOTPverification = 'signup_verify_email';
  static const String endPointResendOTPverification = 'signup_resendcode';
  static const String endPointGetcurruncies = 'signup_user_wallet_currency';
  static const String endPointSignupdata = 'iban_signup_personal';

  static const String endPointUploadProfile = 'signup_uploadprofile';

  static const String endPointGetallwallet = 'iban_dashboard';
  // static const String endPointGetallwallet = 'sdkkyc_dashboard';
  static const String endPointDashboard = 'dashboard_wallet';
  static const String endPointmaindash = 'dashboard';

  static const String endPointSharemail = 'iban_shareiban';
  static const String endPointclosenotifcation = 'iban_close';

  static const String endPointordercard = 'debitcard_fees';

  static const String endPointdebitcard_order = 'debitcard_order';

  static const String endPointSendTransaction = 'crypto_withdraw';

  static const String endPointNetwork = 'wcoin_getnetwork';

  static const String endPointconfirmexchange = 'crypto_submit_exchange';
  static const String endPointmovebalance = 'move_maincrypto_to_debitcrypto';

  static const String endPointGetWalletList = 'wallet_currency_list';
  static const String endPointMoveeurotoiban = 'wcoin_move_ceur_to_iban';
  static const String endPointeurotocrypto = 'iban_depositeurcrypto';

  static const String endPointCreatewallet = 'create_wallet';
  static const String endPointwalletconertion = 'conversion_wallet_list';
  static const String endPointConversion = 'conversion_wallet';
  static const String endPointwirecurruncy = 'wire_country_currency';
  static const String endPointCryptooins = 'wcoin_crypto_wallet';
  static const String endPointCoindetails = 'wcoin_crypto_wallet_detail';

  static const String endPointSenmessage = 'sendMessage';
  static const String endPointReadmessages = 'readMessage';

  static const String endPointSendinternalcoin = 'crypto_withdraw_beneficary';

  static const String endPointGenerateqr = 'wcoin_generate_qrcode';
  static const String endPointlistofsavedaddress = 'wcoin_listaddress';

  static const String endPointsavesenderadd = 'wcoin_save_sender_address';

  static const String endPointqetqrcode = 'wcoin_crypto_qrcode';
  static const String endPointcryptomain = 'wcoin_move_crypto_to_main';

  static const String endPointmaincrypto = 'wcoin_move_main_to_crypto';

  static const String endPointcryptotradelist = 'crypto_trade_list';

  static const String endPointcryptoPreview = 'crypto_exchange_preview';

  static const String endPointautotrading = 'ongoing_autotrading_profit';
  static const String endPointcompletetrading = 'completed_autotrading_profit';

  static const String endPointResendOTP = 'resendotp';
  static const String endPointSignup = 'signup';
  static const String endPointActivateAccount = 'activate_account';
  static const String endPointResendCode = 'resendcode';
  static const String endPointUploadKycIos = 'upload_kyc_ios';
  static const String endPointSendchatimg = 'sendImgMessage';

  static const String endPointUploadVideo = 'upload_video';
  static const String endPointGetUserStatus = 'get_user_app_status';
  static const String endPointNationality = 'nationality';
  static const String endPointCheckExistingEmail = 'check_existing_email';
  static const String endPointSetUserPin = 'sdkkyc_userSetpin';
  static const String endPointSendkyclink = 'iban_sendkyclink';
  static const String endPointgetplans = 'iban_getPlan';
  static const String endPointUpgradeplan = 'iban_upgradePlan';
  static const String endPointplanlink = 'iban_getPlanLink';

  static const String endPointUserGetPin = 'sdkkyc_userGetpin';
  static const String endPointCreateIban = 'create_iban';
  static const String endPointIbanFees = 'iban_fees';
  static const String endPointPprocessIban = 'process_iban';
  static const String endPointCardFees = 'card_fees';
  static const String endPointCardOrder = 'card_order';
  static const String endPointCardDetails = 'card_details';
  static const String endPointUpdateCardSettings = 'update_card_settings';
  static const String endPointBeneficiaryList = 'iban_beneficiary_list';
  static const String endPointIbanpush = 'iban_sendPush';
  static const String endPointIbancheckcard = 'iban_checkCard';

  static const String endPointSepa = 'iban_sepatype';

  static const String endPointResetCardPin = 'reset_card_pin';
  static const String endPointTransactionList = 'transaction_list';
  static const String endPointBeneficiaryCountries = 'beneficiary_countries';
  static const String endPointAddBeneficiary = 'add_beneficiary';
  static const String endPointUserProfile = 'user_profile';
  static const String endPointdeleteUserProfile = 'delete_user_account';
  static const String endPointIbanregula = 'iban_regulaupdateBiometric';

  static const String endPointSendMoney = 'iban_sendmoney';
  static const String endPointAppSignIn = 'iban_appsignin';
  static const String endPointVerifyAccountSignIn = 'verifyaccount';
  static const String endPointApproveBrowserLogin = 'approve_browser_login';
  static const String endPointApproveTransaction = 'approve_transaction';
  static const String endPointApproveibanTransaction = 'iban_confirmpush';
  static const String endPointprofile = 'iban_profile';
  static const String endPointlogout = 'iban_logout';
  static const String endPointApproveeurotoiban =
      'wcoin_approve_cryptoeur_to_iban';

  static const String endPointApproveeurotocrypto =
      'iban_confirm_transaction_crypto';

  static const String endPointApproveHscardTransaction =
      'hs_confirm_generate_virtual_card';

  static const String endPointNotificationsList = 'notifications_list';
  static const String endPointCoinlist = 'iban_checkappv';
  static const String endPointcheckappversion = 'iban_checkappv';

  static const String endPointselectcoin = 'select_coin_by_user';
  static const String endPointportfolio = 'portfolio';
  static const String endPointsortportfolio = 'sort_portfolio';
  static const String endPointMovebalancetodebit = 'moveBalancewallet';
  static const String endPointdebittowallet = 'move_debitcrypto_to_maincrypto';
  static const String endPointamounlist = 'stripe_amount_list';
  static const String endPointAppleamounlist = 'stripe_amount_apple_list';

  static const String endPointstipefees = 'stripe_fee';
  static const String endPointstipeapplefees = 'stripe_apple_fee';

  static const String endPointstipedeposite = 'stripe_deposit';
  static const String endPointresnedliivness = 'virtualcard_hs_resend_liveness';
  static const String endPointChangecardstatus = 'cardChangeStatus';

  static const String endPointstipeKeys = 'stripe_key';
  static const String endPointcheckusre = 'check_user_for_load';
  static const String endPointMultiloadcard = 'multi_load_balance_card';
  static const String endPointconfirmotp = 'confirm_loadcard_otp';
  static const String endPointaddcardkyc = 'upload_topup_kyc_document';
  static const String endPointcardkyc = 'topup_kyc_status';

  static const String endPointverifiedcard = 'getverifiedcard';
  static const String endPointDeleteverifiedcard = 'delete_topup_kyc';

  static const String endPointFetchLinks = 'config';
  static const String endPointNotificationsUpdate = 'notifications_update';
  static const String endPointSuccessTransaction = 'success_transaction';
  static const String endPointIBANAccounts = 'iban_accounts';
  static const String endPointMoveBalance = 'movebalance';
  static const String endPointInternalApproveTransaction =
      'internal_approve_transaction';
  static const String endPointTempActivateAccount = 'temp_activate_account';
  static const String endPointCardImage = 'card_image';
  static const String endPointDeleteBeneficiary = 'iban_delete_beneficiary';
  static const String endPointWireTransfer = 'deposit';
  static const String endPointVoucher = 'voucher';
  static const String endPointVirtualfees = 'virtual_gc_fee';
  static const String endPointVirtualcardfees = 'virtualcard_fee';
  static const String endPointVirtualcardhsfees = 'virtualcard_hs_fee';

  static const String endPointVirtualgenerate = 'generate_virtual_card';
  static const String endPointhsVirtualgenerate = 'hs_generate_virtual_card';

  static const String endPointVirtualcardlogs = 'virtual_cardlogs';
  static const String endPointVirtualhscardlogs = 'hs_virtual_cardlogs';

  static const String endPointVirtualcardactivate = 'virtualcard_card_activate';

  static const String endPointVirtualcardhsactivate =
      'virtualcard_hs_card_activate';

  static const String endPointPayQrCode = 'payqrcode';
  static const String endPointPrepaidCardFees = 'card_fees';
  static const String endPointdebitcard_fees = 'debitcard_fees';
  static const String endPointdebitcardplans = 'getMetalcard';
  static const String endPointdebitcardplanspreview = 'preview_plan';
  static const String endPointPosStatus = 'pos_order_status';
  static const String endPointPosdevices = 'pos_list';
  static const String endPointPosprview = 'pos_preview';
  static const String endPointPosConfirm = 'pos_order';
  static const String endPointPosSeial = 'pos_order_verify';
  static const String endPointsenddocs = 'pos_update_merchant_profile';
  static const String endPointPoscurruncylist = 'pos_user_currency';
  static const String endPointmakepayment = 'pos_make_payment';
  static const String endPointposplans = 'pos_plan';
  static const String endPointposselectplan = 'pos_choose_plan';
  static const String endPointPoscancel = 'pos_cancel_request_payment';
  static const String endPointposrecipt = 'pos_send_notification';
  static const String endPointpostrans = 'pos_transaction_log';
  static const String endPointposRefund = 'pos_refund_trx';
  static const String endPointposaproveimage = 'pos_make_payment_proof';

  static const String endPointconfirmmovewallet =
      'confirmIbantowalletTransaction';

  static const String endPointCreditcarddetails = 'debitcard_details';
  static const String endPointtrxdetails = 'iban_trxfetail';
  static const String endPointdawnloainvoice = 'iban_downloadinvoice';

  static const String endPointgetcarddetails = 'get_card_details';

  static const String endPointdebittrx = 'debitcard_trx_logs';
  static const String endPointprepaidcardtrans = 'ctrx';

  static const String endPointPrepaidCardActivate = 'card_activate';
  static const String endPointPrepaidCardActivatenew = 'prepaid_card_activate';
  static const String endPointdebitCardActivatenew = 'debitcard_activate_code';

  static const String endPointdebitcard_activate = 'debitcard_activate';

  static const String endPointPrepaidCardDetails = 'card_details';
  static const String endPointLoadPrepaidCardBalance = 'load_balance_card';
  static const String endPointLoadPrepaidCardBalanceConfirm =
      'load_balance_card_confirm';
  static const String endPoint_QR_PAY_RECEIVER_INFO = 'getuserqrcode';
  static const String endPointAddInterBeneficiary = 'add_internal_beneficiary';
  static const String endPointShareQrCode = 'shareqrcode';
  static const String endPointUploadAddressProof = 'address_proof';

  static const String endPointgetbtcwallet = 'getbtcwallet';
  static const String endPointdebitmodule = 'debitcard_module_active';

  static const String endPointLoadmultiPrepaidCardBalanceConfirm =
      'confirm_loadcard_with_push';

  static const String endPointvirtualcardConfirm =
      'confirm_generate_virtual_card';

  //git card api
  static const String giftCardList = 'gcard_list';
  static const String giftCardGetFeeType = 'gcard_getType';
  static const String giftCardGetFeeData = 'gcard_getFee';
  static const String giftCardOrderConfirm = 'gcard_orderCard';
  static const String giftCardDetails = 'gcard_details';
  static const String giftCardDelete = 'gcard_delete';
  static const String giftCardShare = 'gcard_share';

  //kyc section
  static const String kycCreateStatus = 'akyc_createApplicationapp';
  static const String kycGetUserAppStatus = 'akyc_get_user_app_status';
  static const String kycDocumentType = 'akyc_documentType';
  static const String kycIdVerify = 'akyc_uploadIdDocument';
  static const String kycAddressVerify = 'akyc_uploadAddressDocument';
  static const String kycUserImage = 'akyc_readIddocument';
  static const String kycFaceVerify = 'akyc_uploadProfile';
  static const String kycSubmit = 'akyc_submitForm';

  //card section
  static const String cardList = 'trcard_getListCard';
  static const String cardOrderType = 'trcard_getOrdertype';
  static const String cardType = 'trcard_getCardType';
  static const String cardServiceFee = 'trcard_getCardServiceFee';
  static const String cardOrderConfirm = 'trcard_orderCard';
  static const String cardDetails = 'trcard_getCarddetail';
  static const String cardActiveDetails = 'trcard_activateCard';
  static const String cardSetting = 'trcard_cardSetting';
  static const String cardBlockUnblock = 'trcard_blockUnblock';
  static const String cardReplace = 'trcard_replace';
  static const String cardIbanList = 'trcard_getAlliban';
  static const String cardTopupAmount = 'trcard_getLoadcardFee';
  static const String cardTopupConfirm = 'trcard_confirmLoadCard';

  //payment information
  static const String trxPaymentDetails = 'trcard_get3dsdata';
  static const String trxPaymentConfirmOrCancel = 'trcard_approveDeclined';
  static const String cardBeneficiaryList = 'trcard_getCardbeneficiary';

  //for virtual card section
  static const String addCardBeneficiary = 'trcard_addCardbeneficiary';
  static const String deleteCardBeneficiary = 'trcard_deleteCardbeneficiary';
  static const String cardToCardTransferFee = 'trcard_getFeecardtocard';
  static const String cardToCardTransferConfirm = 'trcard_loadCardToCard';
  static const String downloadTransactionStatement = 'iban_statment';

  //crypto stake
  static const String stakePeriod = 'stake_period';
  static const String stakeRequest = 'stake_request';
  static const String stakeOverview = 'stake_log';
  static const String stakeCustomLog = 'stake_customlog';
  static const String stakeProfitLog = 'stake_profitlogs';
  static const String stakeStop = 'stake_stop';
  static const String stakeFeeBalance = 'stake_getfeebalance';
  static const String stakeOrder = 'stake_order';
  static const String stakeConfirm = 'stake_confirm';
  static const String stakeCustomPeriod = 'stake_customperiod';

  //change password
  static const String changePassword = 'iban_changePassword';
  static const String changePasswordOtp = 'iban_confirmchangePassword';


  //iban list
  static const String endPointIbanlist = 'iban_getAlliban';
  static const String endPointcreatiban = 'iban_createiban';
  static const String getIbanCurrency = 'iban_getIbanCurrency';
  // static const String ibanCheckSumSubVerified = 'iban_checkSumsubverfied';
  static const String ibanCheckSumSubVerified = 'sdkkyc_checkSumsubverfied';

  /*master node section*/
  static const String nodeModule = 'mnode_module';
  static const String nodeLogs = 'mnode_logs';
  static const String nodeProfitLogs = 'mnode_profitLogs';
  static const String nodeGetOrderInfo = 'mnode_getorderInfo';
  static const String nodeOrder = 'mnode_order';


  ///////////////////////////////////////////////////////////////////

  // static const String endPointGetuserstatus = 'iban_get_user_app_status';
  static const String endPointGetuserstatus = 'akyc_get_user_app_status';



  /*new api system with sumsub section*/
  static const String getUserAppStatus = 'sdkkyc_getStatus';
  static const String userSignupAccount = 'sdkkyc_signupemail';
  static const String userSignupOnboardProfile = 'sdkkyc_onboardProfile';
  static const String userSignupEmailVerification = 'sdkkyc_verifyemail';
  static const String refreshSumSubToken = 'sdkkyc_sumsubRefreshToken';
  static const String userLoginAccount = 'sdkkyc_login';
  static const String userLoginVerify = 'sdkkyc_verifylogin';
  static const String userLoginBiometric = 'sdkkyc_updateBioStatus';
  static const String userKycCheckStatus = 'sdkkyc_checkKycstatus';
  static const String kycUploadIdDoc = 'sdkkyc_uploadIdDocument';
  static const String kycUploadAddressDoc = 'sdkkyc_uploadAddressDocument';
  static const String kycFaceVerifyImage = 'sdkkyc_readIddocument';
  static const String kycFaceVerifyDoc = 'sdkkyc_uploadProfile';
  static const String kycSubmitData = 'sdkkyc_submitForm';

  //forgot password section
  static const String forgotPasswordApi = 'sdkkyc_forgotPassword';
  static const String forgotPasswordVerifyOtpApi = 'sdkkyc_verifyotp';
  static const String forgotPasswordBiometricStatusApi = 'sdkkyc_updateForgotpasswordBioStatus';
  static const String updatePasswordApi = 'sdkkyc_updatePassword';

}

enum HttpMethod { Get, Post, Put, Patch, Delete }

class NetworkManager {
  static final NetworkManager _singleton = NetworkManager._internal();

  factory NetworkManager() {
    return _singleton;
  }

  NetworkManager._internal();

  Dio dio = Dio();

  void setDioOptions() {
    dio.options.contentType = Headers.jsonContentType;
  }

  Future<Response?> callApi({
    required HttpMethod method,
    required String urlEndPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? body,
    FormData? formData,
    bool isMedia = false,
  }) async {
    this.setDioOptions();
    var requestURL;
    requestURL = AppConfig.baseUrl + urlEndPoint;

    debugPrint("Request URL: $requestURL");

    if (await ConnectionStatusSingleton.getInstance().isConnectedToInternet()) {
      try {
        switch (method) {
          case HttpMethod.Get:
            return await dio.get(
              requestURL,
              queryParameters: queryParameters,
              options: options,
            );
            break;
          case HttpMethod.Post:
            Response response = await dio.post(
              requestURL,
              queryParameters: queryParameters,
              options: options,
              data: isMedia ? formData : body,
            );

            Map jsonResponse = jsonDecode(response.data);

            if (jsonResponse['status'] == 101) {
              // Application.navKey.currentState.push(
              //   MaterialPageRoute(builder: (context) => NoNetworkConnectionScreen()),
              // );

              debugPrint("jsonResponse['status']");
              debugPrint(response.toString());
            } else {
              if (response.data.contains('!DOCTYPE html')) {
                try {
                  Application.navKey.currentState!.push(
                    MaterialPageRoute(
                        builder: (context) => ServerErrorScreen(
                              data: response.data.toString(),
                            )),
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              } else {
                return response;
              }
            }

            break;
          case HttpMethod.Put:
            return await dio.put(
              requestURL,
              queryParameters: queryParameters,
              options: options,
              data: formData,
            );
            break;
          case HttpMethod.Patch:
            break;
          case HttpMethod.Delete:
            return await dio.delete(
              requestURL,
            );
            break;
        }
      } on DioError catch (error) {
        Map<String, dynamic> errorResponse = error.response!.data;

        Response errResponse = Response(
            data: errorResponse,
            statusCode: error.response!.statusCode,
            requestOptions: RequestOptions());
        return errResponse;
      }
    } else {
      debugPrint("Request URL11: $requestURL");
      Application.navKey.currentState!.push(
        MaterialPageRoute(builder: (context) => NoNetworkConnectionScreen()),
      );
      Response errResponses = Response(requestOptions: RequestOptions());

      return errResponses;
    }
    return null;
  }
}
