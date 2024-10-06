import 'dart:convert';

import 'package:codegopay/Models/Coin_qr_model.dart';
import 'package:codegopay/Models/Crypto_coins_model.dart';
import 'package:codegopay/Models/coin_details_model.dart';
import 'package:codegopay/Models/convert_preview_model.dart';
import 'package:codegopay/Models/crypto/stake_period_model.dart';
import 'package:codegopay/Models/crypto/stake_profit_log.dart';
import 'package:codegopay/Models/crypto/stake_stop_model.dart';
import 'package:codegopay/Models/investment/buy_master_node_model.dart';
import 'package:codegopay/Models/investment/node_check_module_model.dart';
import 'package:codegopay/Models/investment/node_logs_model.dart';
import 'package:codegopay/Models/investment/node_profit_log_model.dart';
import 'package:codegopay/Models/networks_token.dart';
import 'package:codegopay/Models/networktype.dart';
import 'package:codegopay/Models/status_model.dart';
import 'package:codegopay/networking/network_manager.dart';
import 'package:codegopay/utils/api_exception.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../Models/crypto/eur_withdraw_model.dart';
import '../../../Models/crypto/iban_deposit_eur_to_crypto_cancel_model.dart';
import '../../../Models/crypto/iban_deposit_eur_to_crypto_model.dart';
import '../../../Models/crypto/new_stake_request_model.dart';
import '../../../Models/crypto/stake_confirm_model.dart';
import '../../../Models/crypto/stake_custom_period_model.dart';
import '../../../Models/crypto/stake_fee_balance_model.dart';
import '../../../Models/crypto/stake_order_model.dart';
import '../../../Models/crypto/stake_overview_model.dart';
import '../../../Models/iban_list/iban_list.dart';

class InvestmentRepo {
  Future nodeCheckModule() async {
    String userId = await UserDataManager().getUserId();
    String token = await UserDataManager().getToken();

    try {
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      debugPrint("node module data: $bodyData");
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.nodeModule);

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      debugPrint("node module data: $response");

      if (jsonResponse["status"] == 0) {
        return StatusModel.fromJson(jsonResponse);
      } else {
        return NodeCheckModuleModel.fromJson(jsonResponse);
      }
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

  Future nodeLogs() async {
    String userId = await UserDataManager().getUserId();
    String token = await UserDataManager().getToken();

    try {
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      debugPrint("node module data: $bodyData");
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.nodeLogs);

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      debugPrint("node module data: $response");

      if (jsonResponse["status"] == 0) {
        return StatusModel.fromJson(jsonResponse);
      } else {
        return NodeLogsModel.fromJson(jsonResponse);
      }
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

  Future nodeProfitLogs({required String orderId}) async {
    String userId = await UserDataManager().getUserId();
    String token = await UserDataManager().getToken();

    try {
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "order_id": orderId,
      };

      debugPrint("node profit data: $bodyData");
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.nodeProfitLogs);

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      debugPrint("node profit data: $response");

      if (jsonResponse["status"] == 0) {
        return StatusModel.fromJson(jsonResponse);
      } else {
        return NodeProfitLogModel.fromJson(jsonResponse);
      }
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

  Future buyMasterNodeInfo() async {
    String userId = await UserDataManager().getUserId();
    String token = await UserDataManager().getToken();

    try {
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
      };

      debugPrint("node profit data: $bodyData");
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.nodeGetOrderInfo);

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      debugPrint("node profit data: $response");

      if (jsonResponse["status"] == 0) {
        return StatusModel.fromJson(jsonResponse);
      } else {
        return BuyMasterNodeModel.fromJson(jsonResponse);
      }
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

  Future orderMasterNode({required int numberOfNode}) async {
    String userId = await UserDataManager().getUserId();
    String token = await UserDataManager().getToken();

    try {
      Map<String, dynamic> bodyData = {
        "authkey": AppConfig.authKey,
        "secretkey": AppConfig.secretKey,
        "whitelablel": AppConfig.whiteLabel,
        "user_id": userId,
        "token": token,
        "number_of_node": numberOfNode,
      };

      debugPrint("node order data: $bodyData");
      Response? response = await NetworkManager().callApi(
          method: HttpMethod.Post,
          body: bodyData,
          urlEndPoint: AppConfig.nodeOrder);

      Map<String, dynamic> jsonResponse = jsonDecode(response!.data);
      debugPrint("node order data: $response");

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
}
