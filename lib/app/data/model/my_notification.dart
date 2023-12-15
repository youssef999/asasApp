class NotificationResponse {
  int? currentPage;
  List<MyNotification>? notifications;
  int? lastPage;
  int? perPage;
  int? total;

  NotificationResponse(
      {this.currentPage, this.notifications, this.lastPage, this.perPage, this.total});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      notifications = <MyNotification>[];
      json['data'].forEach((v) {
        notifications!.add(MyNotification.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (notifications != null) {
      data['data'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}


class MyNotification {
  int? id;
  String? title;
  String? body;
  String? type;
  String? idType;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  MyNotification(
      {this.id,
        this.title,
        this.body,
        this.type,
        this.idType,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  MyNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    idType = json['id_type'];
    isRead = json['id_notefication_reads'] == null ? false : true;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['type'] = type;
    data['id_type'] = idType;
    data['id_notefication_reads'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}