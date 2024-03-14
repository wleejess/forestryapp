/// Mistletoe uniformity measures the consistent distribution of mistletoe parasites
/// within a forest or woodland.
///
/// It helps assess mistletoe's impact on forest health
/// and informs management strategies to mitigate infestations.
enum MistletoeUniformity {
  na("N/A"),
  uniform("Uniform throughout stand"),
  spotty("Spotty");

  const MistletoeUniformity(this.label);

  final String label;
}
