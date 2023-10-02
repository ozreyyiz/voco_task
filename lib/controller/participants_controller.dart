import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';
import '../service/participants_service.dart';

class ParticipantsStateNotifier
    extends StateNotifier<AsyncValue<List<UserModel>>> {
  final ParticipantsService service = ParticipantsService();

  ParticipantsStateNotifier() : super(const AsyncValue.loading()) {
    getParticipants();
  }

  Future<void> getParticipants() async {
    try {
      final participants = await service.getParticipants();
      state = AsyncValue.data(participants);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final participantsProvider = StateNotifierProvider<ParticipantsStateNotifier,
    AsyncValue<List<UserModel>>>(
  (ref) => ParticipantsStateNotifier(),
);
