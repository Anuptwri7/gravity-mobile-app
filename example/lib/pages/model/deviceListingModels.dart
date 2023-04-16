class DeviceListings {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  DeviceListings({this.count, this.next, this.previous, this.results});

  DeviceListings.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String guid;
  String title;
  String image;

  Results({this.guid, this.title, this.image});

  Results.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}