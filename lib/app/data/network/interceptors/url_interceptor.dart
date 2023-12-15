import 'dart:async';
import 'package:chopper/chopper.dart';

class UrlInterceptor implements RequestInterceptor  {


  @override
  FutureOr<Request> onRequest(Request request) async {
    if(request.parameters.containsKey('access_key')){
      return request.copyWith(
        baseUri: Uri.parse('https://service.apicurrency.com')
        );
    }else{
      return request;
    }
  }


}