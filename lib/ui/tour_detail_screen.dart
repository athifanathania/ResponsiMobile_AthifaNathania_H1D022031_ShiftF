import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/services/api_service.dart';
import 'package:manajemenpariwisata/ui/edit_tour_screen.dart';
import 'package:manajemenpariwisata/ui/tour_list_screen.dart';

class TourDetailScreen extends StatefulWidget {
  final int tourId;

  TourDetailScreen({required this.tourId});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  ApiService apiService = ApiService();
  Map<String, dynamic>? tourDetail;

  @override
  void initState() {
    super.initState();
    fetchTourDetail();
  }

  void fetchTourDetail() async {
    try {
      var data = await apiService.showTour(widget.tourId);
      setState(() {
        tourDetail = data;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void navigateToEditScreen() {
    if (tourDetail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditTourScreen(
            tourId: widget.tourId,
            currentTour: tourDetail!['tour'],
            currentDays: tourDetail!['days'],
            currentCost: tourDetail!['cost'],
          ),
        ),
      ).then((value) {
        if (value == true) {
          fetchTourDetail();
        }
      });
    }
  }

  void deleteTour() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin menghapus tur ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "Hapus",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      bool success = await apiService.deleteTour(widget.tourId);
      if (success) {
        Navigator.pop(context, true); // Kembali dan refresh daftar tur
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Gagal menghapus tur"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text(
          'Detail Tur',
          style: TextStyle(
            fontFamily: 'Arial',
          ),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: navigateToEditScreen,
          ),
        ],
      ),
      body: tourDetail == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tour: ${tourDetail!['tour']}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              color: Colors.red[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Colors.red[700]),
                              SizedBox(width: 8),
                              Text(
                                "${tourDetail!['days']} Hari",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Arial',
                                  color: Colors.red[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.attach_money, color: Colors.red[700]),
                              SizedBox(width: 8),
                              Text(
                                "Rp${tourDetail!['cost']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Arial',
                                  color: Colors.red[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: navigateToEditScreen,
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      'Edit Tur',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: deleteTour,
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      'Hapus Tur',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
