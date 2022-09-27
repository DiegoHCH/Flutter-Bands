class Band {
  late String id;
  late String name;
  int? votes;

  Band({required this.id, required this.name, this.votes});

  factory Band.fromMap(Map<String, dynamic> response) => Band(
      id: response.containsKey('id') ? response['id'] : 'no-id',
      name: response.containsKey('name') ? response['name'] : 'no-name',
      votes: response.containsKey('votes') ? response['votes'] : 'no-votes');
}
