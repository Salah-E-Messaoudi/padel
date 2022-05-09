class AvailibilitySlot {
  AvailibilitySlot({
    required this.slot,
  });

  final String slot;

  factory AvailibilitySlot.fromMap(Map<String, dynamic> json) =>
      AvailibilitySlot(
        slot: (json['slot'] as String).replaceFirst(' to ', ' - '),
      );
}
