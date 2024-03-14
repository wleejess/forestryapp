/// Enum representing various directions.
enum Direction {
  na("N/A"),
  north("North"),
  northeast("North East"),
  east("East"),
  southeast("South East"),
  south("South"),
  southwest("South West"),
  west("West"),
  northwest("North West");

  const Direction(this.label);

  final String label;
}
