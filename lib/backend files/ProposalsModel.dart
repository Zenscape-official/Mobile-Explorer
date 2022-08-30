// To parse this JSON data, do
//
//     final proposalsModel = proposalsModelFromJson(jsonString);

import 'dart:convert';

ProposalsModel proposalsModelFromJson(String str) => ProposalsModel.fromJson(json.decode(str));

String proposalsModelToJson(ProposalsModel data) => json.encode(data.toJson());

class ProposalsModel {
    ProposalsModel({
        this.proposals,
        this.pagination,
    });

    List<ProposalProduct>? proposals;
    Pagination? pagination;

    factory ProposalsModel.fromJson(Map<String, dynamic> json) => ProposalsModel(
        proposals: List<ProposalProduct>.from(json["proposals"].map((x) => ProposalProduct.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "proposals": List<dynamic>.from(proposals!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
    };
}

class Pagination {
    Pagination({
        this.nextKey,
        this.total,
    });

    dynamic nextKey;
    String? total;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        nextKey: json["next_key"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "next_key": nextKey,
        "total": total,
    };
}

class ProposalProduct {
    ProposalProduct({
        this.proposalId,
        this.content,
        this.status,
        this.finalTallyResult,
        this.submitTime,
        this.depositEndTime,
        this.totalDeposit,
        this.votingStartTime,
        this.votingEndTime,
    });

    String? proposalId;
    Content? content;
    Status? status;
    FinalTallyResult? finalTallyResult;
    DateTime? submitTime;
    DateTime? depositEndTime;
    List<TotalDeposit>? totalDeposit;
    DateTime? votingStartTime;
    DateTime? votingEndTime;

    factory ProposalProduct.fromJson(Map<String, dynamic> json) => ProposalProduct(
        proposalId: json["proposal_id"],
        content: Content.fromJson(json["content"]),
        status: statusValues.map[json["status"]],
        finalTallyResult: FinalTallyResult.fromJson(json["final_tally_result"]),
        submitTime: DateTime.parse(json["submit_time"]),
        depositEndTime: DateTime.parse(json["deposit_end_time"]),
        totalDeposit: List<TotalDeposit>.from(json["total_deposit"].map((x) => TotalDeposit.fromJson(x))),
        votingStartTime: DateTime.parse(json["voting_start_time"]),
        votingEndTime: DateTime.parse(json["voting_end_time"]),
    );

    Map<String, dynamic> toJson() => {
        "proposal_id": proposalId,
        "content": content!.toJson(),
        "status": statusValues.reverse[status],
        "final_tally_result": finalTallyResult!.toJson(),
        "submit_time": submitTime!.toIso8601String(),
        "deposit_end_time": depositEndTime!.toIso8601String(),
        "total_deposit": List<dynamic>.from(totalDeposit!.map((x) => x.toJson())),
        "voting_start_time": votingStartTime!.toIso8601String(),
        "voting_end_time": votingEndTime!.toIso8601String(),
    };
}

class Content {
    Content({
        this.type,
        this.title,
        this.description,
        this.changes,
        this.plan,
        this.recipient,
        this.amount,
    });

    Type? type;
    String? title;
    String? description;
    List<Change>? changes;
    Plan? plan;
    String? recipient;
    List<TotalDeposit>? amount;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        type: typeValues.map[json["@type"]],
        title: json["title"],
        description: json["description"],
        changes: json["changes"] == null ? null : List<Change>.from(json["changes"].map((x) => Change.fromJson(x))),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        recipient: json["recipient"],
        amount: json["amount"] == null ? null : List<TotalDeposit>.from(json["amount"].map((x) => TotalDeposit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "@type": typeValues.reverse[type],
        "title": title,
        "description": description,
        "changes": changes == null ? null : List<dynamic>.from(changes!.map((x) => x.toJson())),
        "plan": plan == null ? null : plan!.toJson(),
        "recipient": recipient,
        "amount": amount == null ? null : List<dynamic>.from(amount!.map((x) => x.toJson())),
    };
}

class TotalDeposit {
    TotalDeposit({
        this.denom,
        this.amount,
    });

    Denom? denom;
    String? amount;

    factory TotalDeposit.fromJson(Map<String, dynamic> json) => TotalDeposit(
        denom: denomValues.map[json["denom"]],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "denom": denomValues.reverse[denom],
        "amount": amount,
    };
}

enum Denom { UAKT }

final denomValues = EnumValues({
    "uakt": Denom.UAKT
});

class Change {
    Change({
        this.subspace,
        this.key,
        this.value,
    });

    String? subspace;
    String? key;
    dynamic value;

    factory Change.fromJson(Map<String, dynamic> json) => Change(
        subspace: json["subspace"],
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "subspace": subspace,
        "key": key,
        "value": value,
    };
}

class ValueClass {
    ValueClass({
        this.bidMinDeposit,
        this.denom,
        this.amount,
        this.votingPeriod,
    });

    String? bidMinDeposit;
    Denom? denom;
    String? amount;
    String? votingPeriod;

    factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        bidMinDeposit: json["bid_min_deposit"],
        denom: json["denom"] == null ? null : denomValues.map[json["denom"]],
        amount: json["amount"],
        votingPeriod: json["voting_period"],
    );

    Map<String, dynamic> toJson() => {
        "bid_min_deposit": bidMinDeposit,
        "denom": denom == null ? null : denomValues.reverse[denom],
        "amount": amount,
        "voting_period": votingPeriod,
    };
}

class Plan {
    Plan({
        this.name,
        this.time,
        this.height,
        this.info,
        this.upgradedClientState,
    });

    String? name;
    DateTime? time;
    String? height;
    String? info;
    dynamic upgradedClientState;

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
        time: DateTime.parse(json["time"]),
        height: json["height"],
        info: json["info"],
        upgradedClientState: json["upgraded_client_state"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "time": time!.toIso8601String(),
        "height": height,
        "info": info,
        "upgraded_client_state": upgradedClientState,
    };
}

enum Type { COSMOS_PARAMS_V1_BETA1_PARAMETER_CHANGE_PROPOSAL, COSMOS_GOV_V1_BETA1_TEXT_PROPOSAL, COSMOS_UPGRADE_V1_BETA1_SOFTWARE_UPGRADE_PROPOSAL, COSMOS_DISTRIBUTION_V1_BETA1_COMMUNITY_POOL_SPEND_PROPOSAL }

final typeValues = EnumValues({
    "/cosmos.distribution.v1beta1.CommunityPoolSpendProposal": Type.COSMOS_DISTRIBUTION_V1_BETA1_COMMUNITY_POOL_SPEND_PROPOSAL,
    "/cosmos.gov.v1beta1.TextProposal": Type.COSMOS_GOV_V1_BETA1_TEXT_PROPOSAL,
    "/cosmos.params.v1beta1.ParameterChangeProposal": Type.COSMOS_PARAMS_V1_BETA1_PARAMETER_CHANGE_PROPOSAL,
    "/cosmos.upgrade.v1beta1.SoftwareUpgradeProposal": Type.COSMOS_UPGRADE_V1_BETA1_SOFTWARE_UPGRADE_PROPOSAL
});

class FinalTallyResult {
    FinalTallyResult({
        this.yes,
        this.abstain,
        this.no,
        this.noWithVeto,
    });

    String? yes;
    String? abstain;
    String? no;
    String? noWithVeto;

    factory FinalTallyResult.fromJson(Map<String, dynamic> json) => FinalTallyResult(
        yes: json["yes"],
        abstain: json["abstain"],
        no: json["no"],
        noWithVeto: json["no_with_veto"],
    );

    Map<String, dynamic> toJson() => {
        "yes": yes,
        "abstain": abstain,
        "no": no,
        "no_with_veto": noWithVeto,
    };
}

enum Status { PROPOSAL_STATUS_PASSED, PROPOSAL_STATUS_REJECTED }

final statusValues = EnumValues({
    "PROPOSAL_STATUS_PASSED": Status.PROPOSAL_STATUS_PASSED,
    "PROPOSAL_STATUS_REJECTED": Status.PROPOSAL_STATUS_REJECTED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}
