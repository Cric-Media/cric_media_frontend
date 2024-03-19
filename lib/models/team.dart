import 'admin.dart'; // Import the Admin class
import 'player.dart'; // Import the Player class

class Team {
  String? id;
  String? name;
  String? location;
  String? image;
  Admin? admin;
  List<Player>? players;

  Team({
    this.id,
    this.name,
    this.location,
    this.image,
    this.admin,
    this.players,
  });

  Team.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players!.add(Player.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['image'] = image;
    if (admin != null) {
      data['admin'] = admin!.toJson();
    }
    if (players != null) {
      data['players'] = players!.map((player) => player.toJson()).toList();
    }
    return data;
  }
}
