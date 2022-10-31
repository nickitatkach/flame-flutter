class ToDo {
  late final String? id;
  late final String? title;
  late final String? description;
  late final String? fromDate;
  late final String? fromTime;
  late final String? toDate;
  late final String? toTime;
  late final String? type;
  late final String? priority;
  late final int? progress;

  ToDo();

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json["Id"],
        title = json["Title"],
        description = json["Description"],
        fromDate = json["FromDate"],
        toDate = json["ToDate"],
        fromTime = json["FromTime"],
        toTime = json["ToTime"],
        progress = int.parse(json["c"]);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
        "FromDate": fromDate,
        "ToDate": fromDate,
        "FromTime": fromDate,
        "ToTime": fromDate,
        "Progress": progress
      };
}
