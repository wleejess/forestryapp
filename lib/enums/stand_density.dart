/// Indicates the concentration of trees within a stand.
///
/// Stand density refers to the number of trees per unit area in a forest stand.
/// It is a key metric for assessing forest health, growth potential, and ecological
/// conditions. Understanding stand density helps foresters manage forest resources,
/// plan harvesting activities, and maintain biodiversity within ecosystems.
enum StandDensity {
  na("N/A"),
  low("Low"),
  medium("Medium"),
  high("High");

  const StandDensity(this.label);

  final String label;
}
