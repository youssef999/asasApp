class TotalRate {
  int? id;
  String? idCompany;
  int? scientificLevel;
  int? activityLevel;
  int? buildingsAndStadiums;
  int? attentionAndCommunication;
  int? disciplineAndCleanliness;
  int? rateTotal;
  int? countRate;
  String? createdAt;
  String? updatedAt;

  TotalRate(
      {this.id,
        this.idCompany,
        this.scientificLevel,
        this.activityLevel,
        this.buildingsAndStadiums,
        this.attentionAndCommunication,
        this.disciplineAndCleanliness,
        this.rateTotal,
        this.countRate,
        this.createdAt,
        this.updatedAt});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCompany = json['id_company'];
    scientificLevel = json['scientific_level'];
    activityLevel = json['activity_level'];
    buildingsAndStadiums = json['buildings_and_stadiums'];
    attentionAndCommunication = json['attention_and_communication'];
    disciplineAndCleanliness = json['discipline_and_cleanliness'];
    rateTotal = json['rate_total'];
    countRate = json['count_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_company'] = idCompany;
    data['scientific_level'] = scientificLevel;
    data['activity_level'] = activityLevel;
    data['buildings_and_stadiums'] = buildingsAndStadiums;
    data['attention_and_communication'] = attentionAndCommunication;
    data['discipline_and_cleanliness'] = disciplineAndCleanliness;
    data['rate_total'] = rateTotal;
    data['count_rate'] = countRate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}