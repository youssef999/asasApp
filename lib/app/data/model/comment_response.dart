class CommentResponse {
  int? currentPage;
  List<Comment>? comments;
  int? lastPage;
  int? perPage;
  int? total;

  CommentResponse(
      {this.currentPage, this.comments, this.lastPage, this.perPage, this.total});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      comments = <Comment>[];
      json['data'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (comments != null) {
      data['data'] = comments!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}

class Comment {
  int? id;
  String? idCompany;
  String? idFather;
  String? opinion;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? fatherName;

  Comment(
      {this.id,
        this.idCompany,
        this.idFather,
        this.opinion,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.fatherName});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCompany = json['id_company'];
    idFather = json['id_father'];
    opinion = json['opinion'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fatherName = json['father_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_company'] = idCompany;
    data['id_father'] = idFather;
    data['opinion'] = opinion;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['father_name'] = fatherName;
    return data;
  }
}