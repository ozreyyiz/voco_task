import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/participants_controller.dart';
import '../core/auth_manager.dart';
import 'login_page.dart';

class ParticipantsPage extends ConsumerWidget {
  const ParticipantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participants = ref.watch(participantsProvider);

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: const Icon(Icons.pin_drop),
        title: const Text(
          "Near Friends",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(AuthProvider).signout();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: participants.when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final participant = data[index];
                    return ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(participant.avatar!),
                      ),
                      title: Text(
                          '${participant.firstName!} ${participant.lastName!}'),
                      subtitle: Text(participant.email!),
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(participantsProvider.notifier).getParticipants();
                    },
                    child: const Text('Try Again'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
