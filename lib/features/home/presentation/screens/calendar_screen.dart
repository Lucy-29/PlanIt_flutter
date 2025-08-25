import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/presentation/cubit/calander_events/events_cubit.dart';
import 'package:ems_1/features/home/presentation/cubit/calander_events/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ems_1/common/widgets/event_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<EventCardModel> fakeEvents = [
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
          location: "location"),
      organizerImage: '',
      desc: '',
      price: 200,
    ),
    EventCardModel(
      title: "مهرجان الموسيقى",
      date: "2025-08-26",
      location: "دمشق",
      imageUrl: "https://via.placeholder.com/150",
      eventType: "Music & Performance 🎵",
      goingCount: 12,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage: '',
      desc: '',
      price: 200,
    ),
    EventCardModel(
      title: "مهرجان الموسيقى",
      date: "2025-08-26",
      location: "دمشق",
      imageUrl: "https://via.placeholder.com/150",
      eventType: "Wellness & Lifestyle 🧘",
      goingCount: 12,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage: '',
      desc: '',
      price: 200,
    ),
    // أضف المزيد حسب الحاجة
  ];
  @override
  void initState() {
    super.initState();
    context.read<CalendarCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CalendarError) {
            return Center(child: Text(state.message));
          }
          if (state is CalendarLoaded) {
            final events = state.events;

            /// Map التواريخ -> لائحة Events
            final Map<DateTime, List<EventCardModel>> eventsByDay = {};
            for (var e in events) {
              final date =
                  DateTime.parse(e.date); // assuming format: "2025-08-25"
              final normalizedDate = DateTime(date.year, date.month, date.day);

              eventsByDay.putIfAbsent(normalizedDate, () => []);
              eventsByDay[normalizedDate]!.add(e);
            }

            /*final selectedEvents =
                _selectedDay == null ? [] : eventsByDay[_selectedDay!] ?? [];*/
            final selectedEvents = _selectedDay == null
                ? []
                : fakeEvents.where((event) {
                    final eventDate = DateTime.parse(event.date);
                    return eventDate.year == _selectedDay!.year &&
                        eventDate.month == _selectedDay!.month &&
                        eventDate.day == _selectedDay!.day;
                  }).toList();
            return Column(
              children: [
                TableCalendar<EventCardModel>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarFormat: CalendarFormat.week,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) {
                    return eventsByDay[day] ?? [];
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xff206173),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xffD99A9A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: selectedEvents.isEmpty
                      ? const Center(child: Text("ما في أحداث بهاليوم"))
                      : ListView.builder(
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            return EventCard(
                              eventCardModel: selectedEvents[index],
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
