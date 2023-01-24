// To parse this JSON data, do
//
//     final proposalsModel = proposalsModelFromJson(jsonString);

import 'dart:convert';
List<ProposalsModel> proposalsModelFromJson(String str) => List<ProposalsModel>.from(json.decode(str).map((x) => ProposalsModel.fromJson(x)));

String proposalsModelToJson(List<ProposalsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProposalsModel {
    ProposalsModel({
        this.id,
        this.title,
        this.description,
        this.proposalRoute,
        this.proposalType,
        this.submitTime,
        this.depositEndTime,
        this.votingStartTime,
        this.votingEndTime,
        this.proposerAddress,
        this.status,
    });

    int? id;
    String? title;
    String? description;
    String? proposalRoute;
    String? proposalType;
    DateTime? submitTime;
    DateTime? depositEndTime;
    DateTime? votingStartTime;
    DateTime? votingEndTime;
    String? proposerAddress;
    String? status;

    factory ProposalsModel.fromJson(Map<String, dynamic> json) => ProposalsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        proposalRoute: json["proposal_route"],
        proposalType: json["proposal_type"],
        submitTime: DateTime.parse(json["submit_time"]),
        depositEndTime: DateTime.parse(json["deposit_end_time"]),
        votingStartTime: DateTime.parse(json["voting_start_time"]),
        votingEndTime: DateTime.parse(json["voting_end_time"]),
        proposerAddress: json["proposer_address"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "proposal_route": proposalRoute,
        "proposal_type": proposalType,
        "submit_time": submitTime!.toIso8601String(),
        "deposit_end_time": depositEndTime!.toIso8601String(),
        "voting_start_time": votingStartTime!.toIso8601String(),
        "voting_end_time": votingEndTime!.toIso8601String(),
        "proposer_address": proposerAddress,
        "status": status,
    };
}
class Plan {
    Plan({
        this.info,
        this.name,
        this.time,
        this.height,
        this.upgradedClientState,
    });

    String? info;
    String? name;
    DateTime? time;
    String? height;
    dynamic upgradedClientState;

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        info: json["info"],
        name: json["name"],
        time: DateTime.parse(json["time"]),
        height: json["height"],
        upgradedClientState: json["upgraded_client_state"],
    );

    Map<String, dynamic> toJson() => {
        "info": info,
        "name": name,
        "time": time!.toIso8601String(),
        "height": height,
        "upgraded_client_state": upgradedClientState,
    };
}
