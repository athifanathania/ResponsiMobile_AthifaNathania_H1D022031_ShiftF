import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/services/api_service.dart';

class EditTourScreen extends StatefulWidget {
  final int tourId;
  final String currentTour;
  final int currentDays;
  final int currentCost;

  EditTourScreen({
    required this.tourId,
    required this.currentTour,
    required this.currentDays,
    required this.currentCost,
  });

  @override
  _EditTourScreenState createState() => _EditTourScreenState();
}

class _EditTourScreenState extends State<EditTourScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late TextEditingController tourController;
  late TextEditingController daysController;
  late TextEditingController costController;

  @override
  void initState() {
    super.initState();
    tourController = TextEditingController(text: widget.currentTour);
    daysController = TextEditingController(text: widget.currentDays.toString());
    costController = TextEditingController(text: widget.currentCost.toString());
  }

  void updateTour() async {
    if (_formKey.currentState!.validate()) {
      String tour = tourController.text;
      int days = int.parse(daysController.text);
      int cost = int.parse(costController.text);

      bool success =
          await apiService.updateTour(widget.tourId, tour, days, cost);
      if (success) {
        Navigator.pop(context, true); // Kembali dengan nilai true jika berhasil
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Gagal mengupdate tur"),
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
          'Edit Tur',
          style: TextStyle(
            fontFamily: 'Arial',
          ),
        ),
        backgroundColor: Colors.red, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: tourController,
                        decoration: InputDecoration(
                          labelText: 'Nama Tur',
                          labelStyle: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.red[700],
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tur tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: daysController,
                        decoration: InputDecoration(
                          labelText: 'Jumlah Hari',
                          labelStyle: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.red[700],
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah hari tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: costController,
                        decoration: InputDecoration(
                          labelText: 'Biaya (Rp)',
                          labelStyle: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.red[700],
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Biaya tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateTour,
                child: Text(
                  'Update Tur',
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
            ],
          ),
        ),
      ),
    );
  }
}
