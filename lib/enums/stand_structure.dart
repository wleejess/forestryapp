/// Describes the arrangement of trees within a forest stand.
///
/// Stand structure includes tree size, age distribution, and spatial arrangement.
enum StandStructure {
  na("N/A"),
  evenAged("Even-aged"),
  twoAged("Two-aged"),
  multiAged("Multi-aged");

  const StandStructure(this.label);

  final String label;
}
