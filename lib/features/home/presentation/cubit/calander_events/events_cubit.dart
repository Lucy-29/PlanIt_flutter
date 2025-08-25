import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/presentation/cubit/calander_events/events_state.dart';
import 'package:dio/dio.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final Dio dio;

  CalendarCubit(this.dio) : super(CalendarInitial());

  /*Future<void> fetchEvents() async {
    emit(CalendarLoading());
    try {
      final response = await dio.get("/my-events/upcoming");
      final data = response.data as List;
      final events = data.map((e) => EventCardModel.fromJson(e)).toList();
      emit(CalendarLoaded(events));
    } catch (e) {
      emit(CalendarError("فشل تحميل الأحداث"));
    }
  }*/
  Future<void> fetchEvents() async {
    emit(CalendarLoading());
    await Future.delayed(const Duration(seconds: 1)); // محاكاة تحميل

    final fakeEvents = [
      EventCardModel(
        title: "مهرجان الموسيقى",
        date: "2025-08-25",
        location: "دمشق",
        imageUrl: "https://via.placeholder.com/150",
        eventType: "Music & Performance 🎵",
        goingCount: 12,
        organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location",
        ),
        organizerImage: '',
        desc: '',
        price: 200,
      ),
      // أضف المزيد إذا بدك
    ];

    emit(CalendarLoaded(fakeEvents));
  }
}
