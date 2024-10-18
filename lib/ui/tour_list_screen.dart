import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/services/api_service.dart';
import 'package:manajemenpariwisata/ui/tour_detail_screen.dart';
import 'package:manajemenpariwisata/ui/add_tour_screen.dart';
import 'package:manajemenpariwisata/ui/edit_tour_screen.dart';

class TourListScreen extends StatefulWidget {
  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  ApiService apiService = ApiService();
  List<dynamic> tours = [];

  @override
  void initState() {
    super.initState();
    fetchTours();
  }

  void fetchTours() async {
    try {
      var data = await apiService.fetchTours();
      setState(() {
        tours = data;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void navigateToAddTour() async {
    bool? refresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTourScreen()),
    );
    if (refresh == true) {
      fetchTours(); // Refresh daftar setelah menambah tur
    }
  }

  void navigateToDetail(int tourId) async {
    bool? refresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TourDetailScreen(tourId: tourId)),
    );
    if (refresh == true) {
      fetchTours(); // Refresh daftar setelah mengedit tur
    }
  }

  void navigateToEditTour(
      int tourId, String currentTour, int currentDays, int currentCost) async {
    bool? refresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTourScreen(
          tourId: tourId,
          currentTour: currentTour,
          currentDays: currentDays,
          currentCost: currentCost,
        ),
      ),
    );
    if (refresh == true) {
      fetchTours(); // Refresh daftar setelah mengedit tur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text(
          'Daftar Tur',
          style: TextStyle(
            fontFamily: 'Arial',
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                tours[index]['tour'],
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Hari: ${tours[index]['days']} - Biaya: Rp${tours[index]['cost']}",
                style: TextStyle(
                  fontFamily: 'Arial',
                ),
              ),
              onTap: () {
                navigateToDetail(tours[index]['id']);
              },
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.red),
                onPressed: () {
                  navigateToEditTour(
                    tours[index]['id'],
                    tours[index]['tour'],
                    tours[index]['days'],
                    tours[index]['cost'],
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTour,
        backgroundColor: Colors.red,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
