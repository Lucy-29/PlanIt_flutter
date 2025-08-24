import 'package:ems_1/features/home/presentation/cubit/provider_request/request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInit());

  Future<void> sendRequest({
    required String providerName,
    required String userName,
    required String eventLocation,
    required String eventDate,
    required String eventTime,
    String? notes,
  }) async {
    emit(RequestLoading());

    try {
      final response = await http.post(
        Uri.parse(
            "http://****.com/api/requests"), // BACKEND API LINK ********************
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "providerName": providerName,
          "userName": userName,
          "eventLocation": eventLocation,
          "eventDate": eventDate,
          "eventTime": eventTime,
          "notes": notes ?? "",
        }),
      );

      if (response.statusCode == 200) {
        emit(RequestSuccess());
      } else {
        emit(RequestFailure("فشل الإرسال: ${response.statusCode}"));
      }
    } catch (e) {
      emit(RequestFailure("خطأ: $e"));
    }
  }
}
