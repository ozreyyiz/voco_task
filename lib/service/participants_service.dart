import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class ParticipantsService {
  final String baseUrl = 'https://reqres.in/api';

  Future<List<UserModel>> getParticipants() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final participants = data['data'] as List;

      return participants.map((p) => UserModel.fromJson(p)).toList();
    } else {
      throw Exception('Veri alınamadı');
    }
  }
}
