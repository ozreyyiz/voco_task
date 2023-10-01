import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class ParticipantsService {
  // API'nin temel URL'i
  final String baseUrl = 'https://reqres.in/api';

  // Katılımcılar verisini almak için metod
 Future<List<UserModel>> getParticipants() async {
    // API'den istek yap
    final response = await http.get(Uri.parse('$baseUrl/users'));
    // Yanıt başarılı ise
    if (response.statusCode == 200) {
      // Yanıtın içeriğini JSON olarak ayrıştır
      final data = jsonDecode(response.body);
      // JSON verisindeki katılımcıları bir liste olarak al
      final participants = data['data'] as List;
      // Liste elemanlarını dart nesnelerine dönüştür
      return participants.map((p) => UserModel.fromJson(p)).toList();
    } else {
      // Yanıt başarısız ise bir hata fırlat
      throw Exception('Veri alınamadı');
    }
  }
}