import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/participants_controller.dart';
import '../core/auth_manager.dart';
import 'login_page.dart';

class ParticipantsPage extends ConsumerWidget {
  // Widget kurucu
  const ParticipantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerdan veriyi al
    final participants = ref.watch(participantsProvider);
    // Veri durumuna göre farklı widgetlar döndür
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
           ref.read(AuthProvider).signout();
            
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  LoginPage()));
        }, icon: Icon(Icons.logout))],
      ),
      body: participants.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final participant = data[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(participant.avatar!),
              ),
              title: Text(participant.firstName! + ' ' + participant.lastName!),
              subtitle: Text(participant.email!),
            );
          },
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: ElevatedButton(
            onPressed: () {
              // Yeniden dene düğmesine basıldığında veriyi yeniden al
              ref.read(participantsProvider.notifier).getParticipants();
            },
            child: Text('Yeniden Dene'),
          ),
        ),
      ),
    );
  }
}
