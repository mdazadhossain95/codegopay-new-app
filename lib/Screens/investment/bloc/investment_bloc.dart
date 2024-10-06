import 'package:codegopay/Models/Coin_qr_model.dart';
import 'package:codegopay/Models/Crypto_coins_model.dart';
import 'package:codegopay/Models/coin_details_model.dart';
import 'package:codegopay/Models/convert_preview_model.dart';
import 'package:codegopay/Models/investment/buy_master_node_model.dart';
import 'package:codegopay/Models/investment/node_check_module_model.dart';
import 'package:codegopay/Models/investment/node_logs_model.dart';
import 'package:codegopay/Models/investment/node_profit_log_model.dart';
import 'package:codegopay/Models/networks_token.dart';
import 'package:codegopay/Models/networktype.dart';
import 'package:codegopay/Models/status_model.dart';
import 'package:codegopay/Screens/investment/bloc/investment_repo.dart';
import 'package:codegopay/utils/api_exception.dart';
import 'package:codegopay/utils/connectivity_manager.dart';
import 'package:bloc/bloc.dart';
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
import '../../../Models/crypto/stake_period_model.dart';
import '../../../Models/crypto/stake_profit_log.dart';
import '../../../Models/crypto/stake_stop_model.dart';
import '../../../Models/iban_list/iban_list.dart';

part 'investment_event.dart';

part 'investment_state.dart';

class InvestmentBloc extends Bloc<InvestmentEvent, InvestmentState> {
  InvestmentBloc() : super(InvestmentState.init()) {
    on<InvestmentEvent>(mapEventToState);
  }

  InvestmentRepo investmentRepo = InvestmentRepo();

  void mapEventToState(
      InvestmentEvent event, Emitter<InvestmentState> emit) async {
    if (event is NodeCheckModuleEvent) {
      emit(state.update(isloading: true));

      try {
        if (ConnectivityManager.isNetworkAvailable) {
          dynamic response = await investmentRepo.nodeCheckModule();

          if (response is StatusModel) {
            emit(state.update(isloading: false, statusModel: response));
          } else {
            emit(
                state.update(isloading: false, nodeCheckModuleModel: response));
          }
        } else {
          emit(state.update(isloading: false));
        }
      } on ApiException catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
        // ignore: use_rethrow_when_possible
        throw (e);
      } catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
      }
    } else if (event is NodeLogsEvent) {
      emit(state.update(isloading: true));

      try {
        if (ConnectivityManager.isNetworkAvailable) {
          dynamic response = await investmentRepo.nodeLogs();

          if (response is StatusModel) {
            emit(state.update(isloading: false, statusModel: response));
          } else {
            emit(state.update(isloading: false, nodeLogsModel: response));
          }
        } else {
          emit(state.update(isloading: false));
        }
      } on ApiException catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
        // ignore: use_rethrow_when_possible
        throw (e);
      } catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
      }
    } else if (event is NodeProfitLogsEvent) {
      emit(state.update(isloading: true));

      try {
        if (ConnectivityManager.isNetworkAvailable) {
          dynamic response =
              await investmentRepo.nodeProfitLogs(orderId: event.orderId);

          if (response is StatusModel) {
            emit(state.update(isloading: false, statusModel: response));
          } else {
            emit(state.update(isloading: false, nodeProfitLogModel: response));
          }
        } else {
          emit(state.update(isloading: false));
        }
      } on ApiException catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
        // ignore: use_rethrow_when_possible
        throw (e);
      } catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
      }
    } else if (event is BuyMasterNodeInfoEvent) {
      emit(state.update(isloading: true));

      try {
        if (ConnectivityManager.isNetworkAvailable) {
          dynamic response = await investmentRepo.buyMasterNodeInfo();

          if (response is StatusModel) {
            emit(state.update(isloading: false, statusModel: response));
          } else {
            emit(state.update(isloading: false, buyMasterNodeModel: response));
          }
        } else {
          emit(state.update(isloading: false));
        }
      } on ApiException catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
        // ignore: use_rethrow_when_possible
        throw (e);
      } catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
      }
    } else if (event is NodeOrderEvent) {
      emit(state.update(isloading: true));

      try {
        if (ConnectivityManager.isNetworkAvailable) {
          dynamic response = await investmentRepo.orderMasterNode(
              numberOfNode: event.numberOfNode);

          emit(state.update(isloading: false, statusModel: response));
        } else {
          emit(state.update(isloading: false));
        }
      } on ApiException catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
        // ignore: use_rethrow_when_possible
        throw (e);
      } catch (e) {
        debugPrint(e.toString());
        emit(state.update(isloading: false));
      }
    }
  }
}
