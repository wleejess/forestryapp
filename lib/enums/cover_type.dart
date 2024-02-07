enum CoverType {
  forest("Forest"),
  meadow("Meadow"),
  wetland("Wetland"),
  rangeland("Rangeland"),
  juniperwoodlands("Juniper Woodlands"),
  other("Other, list below");

  const CoverType(this.label);

  final String label;
}
