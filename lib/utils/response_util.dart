import '../constant/constant.dart';

class ResponseUtil<T> {
  T? data;
  Status? status;
  String? message;

  ResponseUtil({this.data, this.message});

  ResponseUtil.loading() : status = Status.loading;

  ResponseUtil.completed([this.data]) : status = Status.completed;

  ResponseUtil.error([this.message]): status = Status.error;
}
