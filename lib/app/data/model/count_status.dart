class CountStatus {
  int? countReqBook;
  int? countUnderStudying;
  int? countAcceptable;
  int? countRejected;
  int? countCanceled;
  int? countBatchConfirmed;

  CountStatus(
      {this.countReqBook,
        this.countUnderStudying,
        this.countAcceptable,
        this.countRejected,
        this.countCanceled,
        this.countBatchConfirmed});

  CountStatus.fromJson(Map<String, dynamic> json) {
    countReqBook = json['count_req_book'];
    countUnderStudying = json['count_under_studying'];
    countAcceptable = json['count_acceptable'];
    countRejected = json['count_rejected'];
    countCanceled = json['count_canceled'];
    countBatchConfirmed = json['count_batch_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count_req_book'] = countReqBook;
    data['count_under_studying'] = countUnderStudying;
    data['count_acceptable'] = countAcceptable;
    data['count_rejected'] = countRejected;
    data['count_canceled'] = countCanceled;
    data['count_batch_confirmed'] = countBatchConfirmed;
    return data;
  }
}