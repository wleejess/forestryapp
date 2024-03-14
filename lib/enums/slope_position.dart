/// Describes the position of a slope within a landscape.
///
/// Understanding slope position is crucial for analyzing soil erosion, water
/// drainage patterns, and vegetation distribution in a landscape.
enum SlopePosition {
  na("N/A"),
  lower("Lower"),
  middle("Middle"),
  upper("Upper"),
  rigdetop("Ridgetop");

  const SlopePosition(this.label);

  final String label;
}
