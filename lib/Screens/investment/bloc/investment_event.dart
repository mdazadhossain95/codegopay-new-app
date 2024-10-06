part of 'investment_bloc.dart';

class InvestmentEvent {}

class NodeCheckModuleEvent extends InvestmentEvent {}

class NodeLogsEvent extends InvestmentEvent {}

class NodeProfitLogsEvent extends InvestmentEvent {
  String orderId;

  NodeProfitLogsEvent({required this.orderId});
}

class BuyMasterNodeInfoEvent extends InvestmentEvent {}

class NodeOrderEvent extends InvestmentEvent {
  int numberOfNode;

  NodeOrderEvent({required this.numberOfNode});
}


