class Employee {
  final int id;
  final String name;
  final String role;
  final DateTime startDate;
  DateTime? endDate;
  int isArchived;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
    this.isArchived = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': (endDate == null ? null : endDate!.toIso8601String()),
      'isArchived': isArchived == 1 ? 1 : 0,
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        name: json['name'],
        role: json['role'],
        startDate: DateTime.parse(json['startDate']),
        endDate:
            json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        isArchived: json['isArchived']);
  }

  // Convert Employee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': (endDate == null ? null : endDate!.toIso8601String()),
      'isArchived': isArchived,
    };
  }

  Employee copyWith({required int isArchived}) {
    return Employee(
      id: this.id,
      name: this.name,
      role: this.role,
      startDate: this.startDate,
      endDate: this.endDate,
      isArchived: isArchived,
    );
  }
}
