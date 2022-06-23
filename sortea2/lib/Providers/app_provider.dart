import 'package:flutter/material.dart';
import 'dart:math';

class AppProvider with ChangeNotifier {
  int turno = 0;
  List<String> participants = [];
  String winner = '';

  void resetTurno() {
    turno = 0;
  }

  void addParticipant(String name) {
    participants.add(name);
    notifyListeners();
  }

  void resetParticipants() {
    participants.clear();
  }

  void removeParticipants(int index) {
    participants.removeAt(index);
    notifyListeners();
  }

  List<int> returnIndex() {
    List<int> index = [];
    for (int i = 0; i < participants.length; i++) {
      index[i] = i + 1;
    }
    notifyListeners();
    return index;
  }

  void selectWinner() {
    if (turno == 0) {
      int esta = -1;
      for (int i = 0; i < participants.length; i++) {
        if (participants[i][0] == 'M' || participants[i][0] == 'm') {
          esta = i;
          winner = participants[i];
          break;
        }
      }
      if (esta == -1) {
        var rng = new Random();
        if (participants.length > 1) {
          int random = rng.nextInt(participants.length);
          print(random);
          winner = participants[random];
        } else {
          winner = participants[0];
        }
      }
    } else {
      var rng = new Random();
      if (participants.length > 1) {
        int random = rng.nextInt(participants.length);
        print(random);
        winner = participants[random];
      } else {
        winner = participants[0];
      }
    }
    turno = (turno + 1) % 3;
  }
}
