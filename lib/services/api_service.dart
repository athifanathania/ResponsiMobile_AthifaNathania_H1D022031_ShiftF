import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://responsi.webwizards.my.id/api/";

  // Registrasi pengguna
  Future<bool> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}registrasi"),
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    // Tambahkan log untuk debugging
    print("Status Code (Register): ${response.statusCode}");
    print("Response Body (Register): ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // User Login
  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}login"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    // Tambahkan log untuk debugging
    print("Status Code (Login): ${response.statusCode}");
    print("Response Body (Login): ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Fetch all tours
  Future<List<dynamic>> fetchTours() async {
    final response =
        await http.get(Uri.parse("${baseUrl}pariwisata/durasi_tur"));

    // Tambahkan log untuk debugging
    print("Status Code (Fetch Tours): ${response.statusCode}");
    print("Response Body (Fetch Tours): ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Gagal memuat data tur");
    }
  }

  // Create a new tour
  Future<bool> createTour(String tour, int days, int cost) async {
    final response = await http.post(
      Uri.parse("${baseUrl}pariwisata/durasi_tur"),
      body: jsonEncode({
        "tour": tour,
        "days": days,
        "cost": cost,
      }),
      headers: {"Content-Type": "application/json"},
    );

    // Tambahkan log untuk debugging
    print("Status Code (Create Tour): ${response.statusCode}");
    print("Response Body (Create Tour): ${response.body}");

    return response.statusCode == 200;
  }

  // Update an existing tour
  Future<bool> updateTour(int id, String tour, int days, int cost) async {
    final response = await http.put(
      Uri.parse("${baseUrl}pariwisata/durasi_tur/$id/update"),
      body: jsonEncode({
        "tour": tour,
        "days": days,
        "cost": cost,
      }),
      headers: {"Content-Type": "application/json"},
    );

    // Tambahkan log untuk debugging
    print("Status Code (Update Tour): ${response.statusCode}");
    print("Response Body (Update Tour): ${response.body}");

    return response.statusCode == 200;
  }

  // Delete a tour
  Future<bool> deleteTour(int id) async {
    final response = await http.delete(
      Uri.parse("${baseUrl}pariwisata/durasi_tur/$id/delete"),
    );

    // Tambahkan log untuk debugging
    print("Status Code (Delete Tour): ${response.statusCode}");
    print("Response Body (Delete Tour): ${response.body}");

    return response.statusCode == 200;
  }

  // Show details of a specific tour
  Future<Map<String, dynamic>> showTour(int id) async {
    final response =
        await http.get(Uri.parse("${baseUrl}pariwisata/durasi_tur/$id"));

    // Tambahkan log untuk debugging
    print("Status Code (Show Tour): ${response.statusCode}");
    print("Response Body (Show Tour): ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Gagal menampilkan data tur");
    }
  }
}
