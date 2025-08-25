import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/home/presentation/cubit/provider_request/request_cubit.dart';
import 'package:ems_1/features/home/presentation/cubit/provider_request/request_state.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReserveProvider extends StatefulWidget {
  final ServiceProviderModel provider;

  const ReserveProvider({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  State<ReserveProvider> createState() => _ReserveProviderState();
}

class _ReserveProviderState extends State<ReserveProvider> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final today = DateTime.now();

  void _submitReservation() {
    if (_selectedDate == null ||
        _selectedTime == null ||
        _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Please complete all required fields")),
      );
      return;
    }

    final dateStr =
        "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";
    final timeStr =
        "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}";

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title:
              Text(" data check ", style: TextStyle(color: Color(0xFF206173))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📅 Date: $dateStr"),
              SizedBox(height: 8),
              Text("⏰ Time: $timeStr"),
              SizedBox(height: 8),
              Text("📍 Location: ${_locationController.text}"),
              if (_notesController.text.isNotEmpty) ...[
                SizedBox(height: 8),
                Text("📝 Notes: ${_notesController.text}"),
              ]
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Edit"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF206173),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                // هون منبعت الريكويست
                context.read<RequestCubit>().sendRequest(
                      providerName: widget.provider.providerName,
                      userName: "demoUser123", // مؤقت  Auth
                      eventLocation: _locationController.text,
                      eventDate: dateStr,
                      eventTime: timeStr,
                      notes: _notesController.text,
                    );
              },
              child: Text(
                "Send",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F2EA),
      appBar: AppBar(
        title: Text(
          widget.provider.providerName,
          style: TextStyle(color: Color(0xff206173)),
        ),
        //  backgroundColor: Color(0xFF206173),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          if (state is RequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("✅ Reservation submitted successfully")),
            );
            Navigator.pop(context);
          } else if (state is RequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240,
                width: 400,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: Image.network(
                      widget.provider.providerImageUrl,
                      height: 240,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 25,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff206173),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          widget.provider.serviceName,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),

              // ************************* Choose Date *********************

              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text("choose date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF206173))),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9F6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff575C8A).withOpacity(0.3),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    minimumDate: DateTime(today.year, today.month, today.day),
                    maximumDate: DateTime(2028, 12, 31),
                    initialDateTime:
                        DateTime(today.year, today.month, today.day),
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Choose Time & Location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("choose time",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF206173))),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffF9F9F6),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff575C8A).withOpacity(0.3),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        use24hFormat: false,
                        onDateTimeChanged: (time) {
                          setState(() {
                            _selectedTime =
                                TimeOfDay(hour: time.hour, minute: time.minute);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("choose location",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF206173))),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF9F9F6),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff575C8A).withOpacity(0.3),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: "place name",
                          hintStyle: TextStyle(color: Color(0xff206173)),
                          border: InputBorder.none,
                          prefixIcon: Icon(FontAwesomeIcons.mapLocationDot,
                              color: Color(0xFF206173)),
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Notes Field ****************************************
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("extra notes (optional)",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF206173))),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9F6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff575C8A).withOpacity(0.3),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "write any note you want ...",
                      hintStyle: TextStyle(color: Color(0xff206173)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              ),

              Spacer(),
              state is RequestLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitReservation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF206173),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text("SEND REQUEST",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    )
            ],
          );
        },
      ),
    );
  }
}
