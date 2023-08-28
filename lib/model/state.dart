class State {
  String? name;
  int? id;
  State({this.id, this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> state = <String, dynamic>{};
    state['id'] = id;
    state['name'] = name;
    return state;
  }

  factory State.fromJson(Map<String, dynamic>? json) {
    return State(
      id: json?['id'],
      name: json?['name'],
    );
  }
}
