import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:e_siklinik/pages/Antrian/add_antrian.dart';
import 'package:e_siklinik/pages/Antrian/add_antrian.dart';
import 'package:e_siklinik/pages/dashboard.dart';

class AntrianPage extends StatefulWidget {
  @override
  _AntrianPageState createState() => _AntrianPageState();
}

class _AntrianPageState extends State<AntrianPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Antrian',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), 
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: {
                  CalendarFormat.week: '',
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  todayDecoration: BoxDecoration(),
                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color(0xFF234DF0),
                  ),
                  weekendTextStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                  ),
                  outsideTextStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    color: Color(0xFFDDEAFF),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Jadwal Antrian',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddAntrianPage(),
            ),
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
        backgroundColor: Color(0xFF234DF0),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}