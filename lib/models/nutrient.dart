class Nutrient {
  final String name;
  final num value;
  final int id;
  final String unit;

  Nutrient({
    this.name,
    this.value,
    this.id,
    this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return new Nutrient(
        id: json['nutrientId'] as int,
        name: json['nutrientName'] as String,
        unit: json['unitName'],
        value: json['value'] );
  }

  String get formattedValue {
    final valueAsFixed = value?.toStringAsFixed(2) ?? '?';

    return "${valueAsFixed}g";
  }

  @override
  String toString() {
    return "$name $formattedValue";
  }
}
