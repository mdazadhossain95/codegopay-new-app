import 'dart:convert';
import 'dart:developer';

import 'package:codegopay/Models/Regula_model.dart';
import 'package:codegopay/Models/Sendmone_model.dart';
import 'package:codegopay/Models/Sepa_models.dart';
import 'package:codegopay/Models/binficary_model.dart';
import 'package:codegopay/Models/push_model.dart';
import 'package:codegopay/Models/status_model.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/networking/network_manager.dart';
import 'package:codegopay/utils/api_exception.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../../Models/iban_list/iban_list.dart';

class TransferRespo {
  Future getbinficiarylist() async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      debugPrint(" 📒📒📒 bodyData 📒📒📒");
      debugPrint(bodyData.toString());
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointBeneficiaryList);

      debugPrint("response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return BinficaryModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future sepatypes() async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      debugPrint(" bodyData");
      debugPrint(bodyData.toString());
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointSepa);

      debugPrint("response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return Sepatypesmodel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future Swipconfirm({String? id}) async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "unique_id": id
      };

      debugPrint(" bodyData");
      debugPrint(bodyData.toString());
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointIbanpush);

      debugPrint("response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return StatusModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future Sendmoneyfun(
      {String? reference,
        String? amount,
        String? ibanid,
        String? beneficiary,
        String? paymentoption}) async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "reason_payment": reference,
        "amount": amount,
        "beneficiary_id": beneficiary,
        'payment_option': paymentoption,
        'iban_id': ibanid
      };

      debugPrint(" bodyData");
      debugPrint(bodyData.toString());
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointSendMoney);

      debugPrint("response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return SendmoneyModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future updateregula({String? kycid, String? match, userimage}) async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "kyc_request_id": kycid,
        'face_matched': match,
        'userimage': userimage
      };

      print(" bodyData");
      print(bodyData);
      log(bodyData.toString());
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointIbanregula);

      log("response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return RegulaModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<StatusModel> deleteBeneficiary({
    String? uniqueId,
  }) async {
    try {
      print("deleteBeneficiary formData");
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "unique_id": uniqueId,
      };

      print(bodyData);
      Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        body: bodyData,
        urlEndPoint: AppConfig.endPointDeleteBeneficiary,
      );

      print("deleteBeneficiary response : $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return StatusModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<PushModel> approveibanTransaction(
      {required String completed, lat, long, uniqueId}) async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "is_facematch": 1,
        "unique_id": uniqueId,
        "late": lat.toString(),
        "long": long.toString(),
        "status": completed,
      };

      print("approveBrowserLogin bodyData");
      print(bodyData);
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointApproveibanTransaction);

      print("response confirmpush: $response");
      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return PushModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future senduserphoto({String? userimage}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST',
          Uri.parse('${AppConfig.subBaseUrl}/codegopay/post_new'));
      request.body = json.encode({"userimage": userimage});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        log(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      log(e.toString());
      throw (e);
    }
  }

  Future addbinfechary(
      {String? name,
        String? lastname,
        String? image,
        String? iban,
        String? email,
        String? type,
        String? bic,
        String? companyname}) async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      var request = http.MultipartRequest('POST', Uri.parse("${AppConfig.subBaseUrl}/iban_addbeneficary"));
      request.fields.addAll({
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        'first_name': name!,
        "last_name": lastname!,
        "company_name": companyname!,
        'email': email!,
        'account': iban!,
        'is_business_personal': type!,
        "bic": bic!,
      });

      print(request.fields);
      image == '' || image == null
          ? () {}
          : request.files.add(await http.MultipartFile.fromPath(
          'beneficiary_upload_image', image));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
        jsonDecode(await response.stream.bytesToString());
        print(jsonResponse);
        return StatusModel.fromJson(jsonResponse);
      } else {
        print(response.reasonPhrase);
      }
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      print(e);
      throw (e);
    }
  }


  Future ibanlist() async {
    try {
      String userId = await UserDataManager().getUserId();
      String token = await UserDataManager().getToken();

      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      print("allWallet bodyData");
      print(bodyData);
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.endPointIbanlist);

      print("response : " + response.toString());

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      return IbanlistModel.fromJson(jsonResponse);
    } on ApiException catch (e) {
      print(e);
      throw (e);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
