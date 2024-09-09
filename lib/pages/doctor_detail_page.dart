import 'package:doctor_booking/models/doctor.dart';
import 'package:flutter/material.dart';

class DoctorDetailPage extends StatefulWidget {
  // Pass Doctor details model from the previous page
  final DoctorModel doctorModel;
  DoctorDetailPage({super.key, required this.doctorModel});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  List<CalendarModel> calendarData = [];
  List<TimeModel> timeData = [];

  @override
  void initState() {
    calendarData = widget.doctorModel.calendar;
    timeData = widget.doctorModel.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.doctorModel.name} Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            doctorDetails(),
            calendar(),
            SizedBox(
              height: 25,
            ),
            time(),
            SizedBox(
              height: 25,
            ),
            bookingButton(),
          ],
        ),
      ),
    );
  }

  Widget doctorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: widget.doctorModel.imageBox,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(widget.doctorModel.image),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorModel.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.doctorModel.specialties.first,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[400],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.doctorModel.score.toString()),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          "Biography",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.doctorModel.bio,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          "Specialities",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Text(
                  widget.doctorModel.specialties[index],
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: widget.doctorModel.specialties.length),
        ),
      ],
    );
  }

  Widget calendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Calendar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    for (var item in calendarData) {
                      item.isSelected = false;
                    }
                    calendarData[index].isSelected = true;
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: calendarData[index].isSelected
                            ? Color(0xff051a8ff)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 25,
                            color: Color(0xff050618).withOpacity(0.05),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          calendarData[index].dayNumber.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: calendarData[index].isSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text(
                          calendarData[index].dayName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: calendarData[index].isSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 30,
                  ),
              itemCount: calendarData.length),
        ),
      ],
    );
  }

  Widget time() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    for (var item in timeData) {
                      item.isSelected = false;
                    }
                    timeData[index].isSelected = true;
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: timeData[index].isSelected
                            ? Color(0xff051a8ff)
                            : Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 25,
                            color: Color(0xff050618).withOpacity(0.05),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          timeData[index].time,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: timeData[index].isSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
              itemCount: timeData.length),
        ),
      ],
    );
  }

  Widget bookingButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff051a8ff), borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            "Book Now",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
