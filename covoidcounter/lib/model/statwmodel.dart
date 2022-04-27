class StateModel {
  String stateName;
  String active;
  String positive;
  String cured;
  String death;
  String newPositive;
  String newActive;


  StateModel({
    this.stateName = "HEADING",
    this.active = "NEWS_DESCRIPTION",
    this.positive = "IMAGE",
    this.cured = "URL",
    this.death = "CONTENT",
    this.newPositive = "NEWPOSITIVE",
    this.newActive = "NEWActive",
  });

  factory StateModel.fromMap(Map news) {
    return StateModel(
      stateName: news["state_name"],
      active: news["active"],
      positive: news["positive"],
      cured: news["cured"],
      death: news["death"],
      newPositive: news["new_positive"],
      newActive: news["new_active"],

    );
  }
}
