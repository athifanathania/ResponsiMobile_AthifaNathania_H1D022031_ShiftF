import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://103.196.155.42/api";

  // Registrasi pengguna
  Future<bool> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/registrasi"),
      body: jsonEncode({
        "name": name, 
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    return response.statusCode == 200;
  }

  // User Login
  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    return response.statusCode == 200;
  }

  // Fetch all tours
  Future<List<dynamic>> fetchTours() async {
    final response =
        await http.get(Uri.parse("$baseUrl/pariwisata/durasi_tur"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Gagal memuat data tur");
    }
  }

  // Create a new tour
  Future<bool> createTour(String tour, int days, int cost) async {
    final response = await http.post(
      Uri.parse("$baseUrl/pariwisata/durasi_tur"),
      body: jsonEncode({
        "tour": tour,
        "days": days,
        "cost": cost,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  // Update an existing tour
  Future<bool> updateTour(int id, String tour, int days, int cost) async {
    final response = await http.put(
      Uri.parse("$baseUrl/pariwisata/durasi_tur/$id/update"),
      body: jsonEncode({
        "tour": tour,
        "days": days,
        "cost": cost,
      }),
      headers: {"Content-Type": "application/json"},
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete a tour
  Future<bool> deleteTour(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/pariwisata/durasi_tur/$id/delete"),
    );
    return response.statusCode == 200;
  }

  // Show details of a specific tour
  Future<Map<String, dynamic>> showTour(int id) async {
    final response =
        await http.get(Uri.parse("$baseUrl/pariwisata/durasi_tur/$id"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Gagal menampilkan data tur");
    }
  }
}
