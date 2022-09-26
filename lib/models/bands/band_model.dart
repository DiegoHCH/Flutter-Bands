class Band {
  late String id;
  late String name;
  int? votes;

  Band({required this.id, required this.name, this.votes});

  factory Band.fromMap(Map<String, dynamic> response) =>
      Band(id: response['id'], name: response['name'], votes: response['votes']);
}
