  import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';
import '../service/participants_service.dart';

class ParticipantsStateNotifier
    extends StateNotifier<AsyncValue<List<UserModel>>> {
  // Servis sınıfından bir nesne oluştur
  final ParticipantsService service = ParticipantsService();

  // State notifier kurucu
  ParticipantsStateNotifier() : super(AsyncValue.loading()) {
    // Veriyi almak için metod çağır
    getParticipants();
  }

  // Veriyi almak için metod
  Future<void> getParticipants() async {
    try {
      // Servis sınıfının metodunu çağırarak veriyi al
      final participants = await service.getParticipants();
      // Durumu veri yüklendi olarak güncelle
      state = AsyncValue.data(participants);
    } catch (e) {
      // Hata oluşursa durumu hata olarak güncelle
      state = AsyncValue.error(e,StackTrace.current);
    }
  }
}

// State notifier provider oluştur
final participantsProvider = StateNotifierProvider<ParticipantsStateNotifier,
    AsyncValue<List<UserModel>>>(
  (ref) => ParticipantsStateNotifier(),
);