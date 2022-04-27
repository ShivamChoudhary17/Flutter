class VacModel {
  String name;
  String dictName;
  String blockName;
  String from;
  String to;
  String feeType;
  String available;
  String minAgeLimit;
  String maxAgeLimit;
  String vaccine;
  String slots1;
  String slots2;
  String slots3;
  String vacDate;
  String cost;

  VacModel({
    this.name = "HEADING",
    this.dictName = "NEWS_DESCRIPTION",
    this.blockName = "IMAGE",
    this.from = "URL",
    this.to = "CONTENT",
    this.feeType = "NEWPOSITIVE",
    this.available = "NEWActive",
    this.minAgeLimit = "NEWActive",
    this.vaccine = "NEWActive",
    this.maxAgeLimit = "NEWActive",
    this.slots1 = "NEWActive",
    this.slots2 = "NEWActive",
    this.slots3 = "NEWActive",
    this.vacDate = "NEWActive",
    this.cost = "NEWActive",
  });

  factory VacModel.fromMap(Map news) {
    return VacModel(
      name: news["name"],
      dictName: news["district_name"],
      blockName: news["block_name"],
      from: news["from"],
      to: news["to"],
      feeType: news["fee_type"],
      available: news["available_capacity"].toString(),
      minAgeLimit: news["min_age_limit"].toString(),
      maxAgeLimit: news["max_age_limit"].toString(),
      vaccine: news["vaccine"],
      slots1: news["slots"][0].toString(),
      slots2: news["slots"][1].toString(),
      slots3: news["slots"][2].toString(),
      vacDate: news["date"].toString(),
      cost: news["fee"].toString(),
    );
  }
}
