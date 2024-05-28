import 'dart:convert';
import 'package:e_siklinik/pages/Antrian/new_add_antrian.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'add_antrian.dart';
import 'package:e_siklinik/pages/Assessment/add_assessment.dart';

class ListAntrianNew extends StatefulWidget {
  const ListAntrianNew({super.key});

  @override
  State<ListAntrianNew> createState() => _ListAntrianNewState();
}

class _ListAntrianNewState extends State<ListAntrianNew> {
  List<dynamic> antrianList = [];
  List<dynamic> filteredAntrianList = [];
  DateTime selectedDate = DateTime.now();
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  final String apiGetAntrian = "http://192.168.24.175:8080/api/antrian";

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = selectedDate;
    _getAllAntrian();
  }

  Future<void> _getAllAntrian() async {
    try {
      final response = await http.get(Uri.parse(apiGetAntrian));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['antrian'] != null) {
          setState(() {
            antrianList = data['antrian'];
            _filterAntrianByDate();
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load antrian");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _filterAntrianByDate();
    });
  }

  void _filterAntrianByDate() {
    setState(() {
      filteredAntrianList = antrianList.where((antrian) {
        DateTime antrianDate = DateTime.parse(antrian['created_at']
            .toString()); // Assuming the date field is 'tanggal' and formatted correctly
        return isSameDay(antrianDate, _selectedDay);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNewAntrian(),
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
      appBar: AppBar(
        title: Text('Daftar Antrian'),
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendar(),
          Expanded(
              child: filteredAntrianList.isEmpty
                  ? Center(
                      child: Text(
                        'Antrian Kosong',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredAntrianList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final antrian = filteredAntrianList[index];
                        final antrianId = antrian['id'];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            leading: CircleAvatar(
                              child: Text(
                                antrian['no_antrian'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            title: Text(
                              antrian['antrian_to_pasien']['nama'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Antrian Nomor: ${antrian['no_antrian']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAssessment(
                                      antrianId: antrianId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: _onDaySelected,
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(164, 87, 137, 239),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 190, 182, 182),
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
        ),
        headerVisible: false,
        daysOfWeekVisible: false,
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_monthName(_focusedDay.month)} ${_focusedDay.year}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 8),
          // Uncomment and add an image asset if needed
          // Image.asset(
          //   'assets/images/kalender.png',
          //   width: 24,
          //   height: 24,
          // ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
