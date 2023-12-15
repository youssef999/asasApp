import 'package:asas/app/data/model/media.dart';

class Student {
  int? id;
  String? idFather;
  String? name;
  String? nameFather;
  String? dateOfBirth;
  String? gender;
  String? nationality;
  String? countryOfResidence;
  String? idCurriculumType;
  String? currentAcademicCertificates;
  String? sportsOfInterest;
  String? artisticActivitiesOfInterest;
  String? religiousActivitiesOfInterest;
  String? createdAt;
  String? updatedAt;
  List<Media>? media;

  Student(
      {this.id,
        this.idFather,
        this.name,
        this.nameFather,
        this.dateOfBirth,
        this.gender,
        this.nationality,
        this.countryOfResidence,
        this.idCurriculumType,
        this.currentAcademicCertificates,
        this.sportsOfInterest,
        this.artisticActivitiesOfInterest,
        this.religiousActivitiesOfInterest,
        this.createdAt,
        this.media = const [],
        this.updatedAt});

  Student.fromJson(Map<String, dynamic> json) {

    if(json.containsKey('media')){
      media = ( json['media'] as List ).map((e) => Media.fromJson(e)).toList();
    }else{
      media = [];
    }

    if(json.containsKey('data')){
      json = json['data'];
    }
    
    id = json['id'];
    idFather = json['id_father'].toString();
    name = json['name'];
    nameFather = json['name_father'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    nationality = json['nationality'];
    countryOfResidence = json['country_of_residence'];
    idCurriculumType = json['id_curriculum_type'] == 'null' ? null : json['id_curriculum_type'];
    currentAcademicCertificates = json['current_academic_certificates'];
    sportsOfInterest = json['sports_of_interest'];
    artisticActivitiesOfInterest = json['artistic_activities_of_interest'];
    religiousActivitiesOfInterest = json['religious_activities_of_interest'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_father'] = idFather;
    data['name'] = name;
    data['name_father'] = nameFather;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['country_of_residence'] = countryOfResidence;
    data['id_curriculum_type'] = idCurriculumType;
    data['current_academic_certificates'] = currentAcademicCertificates;
    data['sports_of_interest'] = sportsOfInterest;
    data['artistic_activities_of_interest'] = artisticActivitiesOfInterest;
    data['religious_activities_of_interest'] = religiousActivitiesOfInterest;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}