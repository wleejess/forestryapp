/// The Hawksworth rating system assesses ecological value and sensitivity in forestry
/// and conservation. It considers biodiversity, habitat complexity, species rarity,
/// ecosystem services, and disturbance sensitivity to prioritize conservation efforts
/// and inform land management decisions.

enum Hawksworth {
  na("N/A"),
  none("None (0)"),
  low("Low (1-2)"),
  medium("Medium (3-4)"),
  high("High (5-6)");

  const Hawksworth(this.label);

  final String label;
}
