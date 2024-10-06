part of 'investment_bloc.dart';

class InvestmentState {
  bool? isloading;
  StatusModel? statusModel;
  NodeCheckModuleModel? nodeCheckModuleModel;
  NodeLogsModel? nodeLogsModel;
  NodeProfitLogModel? nodeProfitLogModel;
  BuyMasterNodeModel? buyMasterNodeModel;

  InvestmentState({
    this.isloading,
    this.statusModel,
    this.nodeCheckModuleModel,
    this.nodeLogsModel,
    this.nodeProfitLogModel,
    this.buyMasterNodeModel,
  });

  factory InvestmentState.init() {
    return InvestmentState(
        isloading: false,
        statusModel: StatusModel(message: '', status: 222),
        nodeCheckModuleModel: NodeCheckModuleModel(
          status: 222,
          isInvestment: 1,
          stakingProfit: "",
          enduserMasternodeProfit: "",
          period: "",
          wlMasternode: "",
          investmentProfit: "",
        ),
        nodeLogsModel: NodeLogsModel(
          status: 222,
          availableBalance: "",
          numberNode: 0,
          order: [],
        ),
        nodeProfitLogModel: NodeProfitLogModel(
          status: 222,
          orderId: "",
          totalPaid: "",
          logs: [],
        ),
      buyMasterNodeModel: BuyMasterNodeModel(
        status: 222,
        coin: "",
        totalPaymentDay: "",
        termsCondition: "",
        perDayProfit: "",
        dropList: [],
      )
    );
  }

  InvestmentState update({
    bool? isloading,
    StatusModel? statusModel,
    NodeCheckModuleModel? nodeCheckModuleModel,
    NodeLogsModel? nodeLogsModel,
    NodeProfitLogModel? nodeProfitLogModel,
    BuyMasterNodeModel? buyMasterNodeModel,
  }) {
    return InvestmentState(
      isloading: isloading,
      statusModel: statusModel ?? this.statusModel,
      nodeCheckModuleModel: nodeCheckModuleModel ?? this.nodeCheckModuleModel,
      nodeLogsModel: nodeLogsModel ?? this.nodeLogsModel,
      nodeProfitLogModel: nodeProfitLogModel ?? this.nodeProfitLogModel,
      buyMasterNodeModel: buyMasterNodeModel ?? this.buyMasterNodeModel,
    );
  }
}
